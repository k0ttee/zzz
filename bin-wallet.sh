#!/bin/bash

# на основе алгоритма https://secretscan.org/PrivateKeyWif
# вспомогательные конвертеры http://brainwalletx.github.io/#converter




##############
# цикл ввода #
##############

bin=''
echo ""
echo "вводите нули и единицы"
echo -ne "[0/256]\r"

while true
do
	read -n 1 -s char
	
	if [[ $char != "0" && $char != "1" ]]
	then
		continue
	fi

	bin+=$char
	echo -ne "[${#bin}/256]\r"

	if [ "${#bin}" -eq 256 ]
	then
		break
	fi
done

echo -e "\n"




##################
# верхний предел #
##################

decimal=$(echo "obase=10; ibase=2; $bin" | bc | tr -d '\\[:space:]')
limit=115792089237316195423570985008687907852837564279074904382605163141518161494336

if [ "$(echo "$decimal > $limit" | bc)" -eq 1 ]
then
    echo "ВАШЕ ЧИСЛО $decimal"
    echo "ПРЕВЫШАЕТ ЛИМИТ $limit"
    exit 0
fi




###########
# функции #
###########

hex_to_sha256() {
	echo -n $1 | xxd -r -p | openssl dgst -sha256 | awk '{print $2}'
}

encode58() {
    b58chars=123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz
    numHex=$1

    # remain leading 1 in base58
    prefix=''
    if test "00" == "$(echo -n $numHex | cut -c 1-2)"; then
        prefix=1
    fi

    numHex=$(echo -n $numHex | tr a-z A-Z)
    num58=''
    for charIndex in $(echo "obase=58;ibase=16;$numHex" | bc | tr -d '\n\\'); do
        num58=$num58$(echo -n $b58chars | cut -c $(( 10#$charIndex+1 )))
    done
    echo $prefix$num58
}




##########
# логика #
##########

# двоичный → шестнадцатиричный (Bin → Hex)
hex=$(echo "obase=16; ibase=2; $bin" | bc | tr 'A-F' 'a-f')

# добивка шестнадцатиричного нулями слева (стандарт 64 символа)
hex=$(printf "%064s" "$hex" | tr ' ' '0')

# 80 и шестнадцатиричный и 01
wrapped_hex="80${hex}01"

# шестнадцатиричный_в_обёртке → sha256
first_sha=$(hex_to_sha256 $wrapped_hex)

# sha256 → sha256
second_sha=$(hex_to_sha256 $first_sha)

# контрольная сумма (8 первых символов от sha256)
summ=${second_sha:0:8}

# шестнадцатиричный_в_обёртке и констрольная_сумма
wrapped_hex_and_summ=${wrapped_hex}${summ}

# шестнадцатиричный_в_обёртке и констрольная_сумма → base58
wif=$(encode58 $wrapped_hex_and_summ)




########################
# показывает введённое #
########################

row_bin=$(echo -n $bin | fold -w 32)
row_bin=$(echo "$row_bin" | sed 's/.\{8\}/&\t/g')

printf "\e[33m%s\e[0m\n" "$row_bin"
echo ""




##########################
# показывает вычисленное #
##########################

echo "{
	\"шестнадцатиричный\" : {
		\"hex\" : \"$hex\",
		\"[80]hex[01]\" : \"$wrapped_hex\"
	},

	\"контрольные суммы\" : {
		\"1-я sha256\" : \"$first_sha\",
		\"2-я sha256\" : \"$second_sha\",
		\"8 знаков начала 2-й\" : \"$summ\"
	},

	\"[80]hex[01][8 знаков]\" : \"$wrapped_hex_and_summ\",
	
	
	\"приватный ключ (WIF Compressed)\" : \"$wif\"
}" | jq
