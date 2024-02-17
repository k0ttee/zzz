#!/bin/zsh

#список отключенных (true - значит disabled)
launchctl print-disabled system
#включить
sudo launchctl enable system/com.apple.geod
#отключить
sudo launchctl bootout user/205/com.apple.geod


# csrutil disable
# csrutil enable

# CREDITS: Original idea and script disable.sh by pwnsdx https://gist.github.com/pwnsdx/d87b034c4c0210b988040ad2f85a68d3
#   Big Sur revision by b0gdanw https://gist.github.com/b0gdanw/40d000342dd1ba4d892ad0bdf03ae6ea

# TEMPORARILY disabling (e.g. STOPPING via 'bootout') unwanted services on macOS 11 Big Sur and macOS 12 Monterey:
# This version is for a special boot that optimizes for real-time music performance and streaming video.
# Due to the read-only system volume introduced with macOS Catalina, this script can NOT be run in Recovery mode's Terminal.
# For my purposes I leave WiFi enabled, for streaming video to a local router with no internet connection.

# SIP must first be disabled, in Recovery mode's Terminal (`csrutil disable`), then run this script after rebooting.
# To return to normal boot, simply re-enable SIP in Recovery mode's Terminal (`csrutil enable`), and reboot.
# If you want to fully disable the services, uncomment the `launchctl disable` lines, but remember that they will 
#   automatically launch again after you re-enable SIP.

# Big Sur GUI Agents to bootout
TODISABLE=( \
'com.apple.accessibility.MotionTrackingAgent' \
'com.apple.AMPArtworkAgent' \
'com.apple.AMPDeviceDiscoveryAgent' \
'com.apple.AMPDevicesAgent' \
'com.apple.AMPLibraryAgent' \
'com.apple.AMPSystemPlayerAgent' \
'com.apple.amsaccountsd' \
'com.apple.amsengagementd' \
'com.apple.AOSHeartbeat' \
'com.apple.AOSPushRelay' \
'com.apple.ap.adprivacyd' \
'com.apple.ap.adservicesd' \
'com.apple.ap.promotedcontentd' \
'com.apple.appleseed.seedusaged' \
'com.apple.applespell' \
'com.apple.appsleep' \
'com.apple.appstoreagent' \
'com.apple.appstorecomponentsd' \
'com.apple.assessmentagent' \
'com.apple.assistant_service' \
'com.apple.assistantd' \
'com.apple.AssistiveControl' \
'com.apple.avatarsd' \
'com.apple.bird' \
'com.apple.cache_delete' \
'com.apple.CalendarAgent' \
'com.apple.CallHistoryPluginHelper' \
'com.apple.CallHistorySyncHelper' \
'com.apple.cloudd' \
'com.apple.cloudpaird' \
'com.apple.cloudphotod' \
'com.apple.CommCenter' \
'com.apple.commerce' \
'com.apple.contacts.donation-agent' \
'com.apple.ContactsAgent' \
'com.apple.CoreLocationAgent' \
'com.apple.corespeechd' \
'com.apple.corespotlightd' \
'com.apple.corespotlightservice' \
'com.apple.DiagnosticReportCleanup.plist' \
'com.apple.DictationIM' \
'com.apple.email.maild' \
'com.apple.exchange.exchangesyncd' \
'com.apple.familycircled' \
'com.apple.familycontrols.useragent' \
'com.apple.familynotificationd' \
'com.apple.findmymacmessenger' \
'com.apple.followupd' \
'com.apple.FollowUpUI' \
'com.apple.GameController.gamecontrolleragentd' \
'com.apple.gamed' \
'com.apple.homed' \
'com.apple.icdd' \
'com.apple.icloud.findmydeviced.findmydevice-user-agent' \
'com.apple.icloud.fmfd' \
'com.apple.icloud.searchpartyuseragent' \
'com.apple.iCloudHelper' \
'com.apple.iCloudNotificationAgent' \
'com.apple.iCloudUserNotificationsd' \
'com.apple.imagent' \
'com.apple.imautomatichistorydeletionagent' \
'com.apple.imcore.imtransferagent' \
'com.apple.itunescloudd' \
'com.apple.knowledge-agent' \
'com.apple.ManagedClientAgent.agent' \
'com.apple.ManagedClientAgent.enrollagent' \
'com.apple.Maps.mapspushd' \
'com.apple.mediaanalysisd' \
'com.apple.mediaremoteagent' \
'com.apple.mediastream.mstreamd' \
'com.apple.MobileAccessoryUpdater.fudHelperAgent' \
'com.apple.mobiledeviceupdater' \
'com.apple.newsd' \
'com.apple.notificationcenterui.agent' \
'com.apple.parentalcontrols.check' \
'com.apple.parsecd' \
'com.apple.parsec-fbf' \
'com.apple.passd' \
'com.apple.photoanalysisd' \
'com.apple.photolibraryd' \
'com.apple.PhotoLibraryMigrationUtility.XPC' \
'com.apple.protectedcloudstorage.protectedcloudkeysyncing' \
'com.apple.rapportd' \
'com.apple.RapportUIAgent' \
'com.apple.remindd' \
'com.apple.RemoteDesktop.agent' \
'com.apple.RemoteManagementAgent' \
'com.apple.routined' \
'com.apple.Safari.PasswordBreachAgent' \
'com.apple.Safari.SafeBrowsing.Service' \
'com.apple.SafariBookmarksSyncAgent' \
'com.apple.SafariCloudHistoryPushAgent' \
'com.apple.SafariHistoryServiceAgent' \
'com.apple.SafariLaunchAgent' \
'com.apple.SafariNotificationAgent' \
'com.apple.screensharing.agent' \
'com.apple.screensharing.menuextra' \
'com.apple.screensharing.MessagesAgent' \
'com.apple.ScreenTimeAgent' \
'com.apple.SecureBackupDaemon' \
'com.apple.security.cloudkeychainproxy3' \
'com.apple.security.keychain-circle-notification' \
'com.apple.shazamd' \
'com.apple.sidecar-relay' \
'com.apple.Siri.agent' \
'com.apple.siriknowledged' \
'com.apple.SoftwareUpdateNotificationManager' \
'com.apple.speech.speechdatainstallerd' \
'com.apple.speech.synthesisserver' \
'com.apple.Spotlight' \
'com.apple.suggestd' \
'com.apple.syncdefaultsd' \
'com.apple.telephonyutilities.callservicesd' \
'com.apple.TMHelperAgent' \
'com.apple.TMHelperAgent.SetupOffer' \
'com.apple.UsageTrackingAgent' \
'com.apple.UserNotificationCenterAgent' \
'com.apple.videoconference.camera' \
'com.apple.videosubscriptionsd' \
'com.Arturia.ArturiaSoftwareCenterAgent' \
'com.avid.CloudClientServices' \
'com.avid.link' \
'com.avid.transport.client' \
'com.citrixonline.GoToMeeting.G2MUpdate' \
'com.dropbox.DropboxMacUpdate.agent' \
'com.github.facebook.watchman' \
'com.google.keystone.system.agent' \
'com.google.keystone.system.xpcservice' \
'com.logmein.GoToMeeting.G2MUpdate' \
'com.microsoft.OneDriveStandaloneUpdater' \
'com.microsoft.update.agent' \
'com.paceap.eden.licensed.agent' \
'com.skype.skype.shareagent' \
'com.techsmith.snagit.capturehelper2020' \
'homebrew.mxcl.chromedriver' \
'homebrew.mxcl.mongodb' \
'homebrew.mxcl.postgresql' \
'org.pqrs.karabiner.agent.karabiner_grabber' \
'org.pqrs.karabiner.agent.karabiner_observer' \
'org.pqrs.karabiner.karabiner_console_user_server' \
'org.pqrs.karabiner.karabiner_session_monitor' \
'org.pqrs.karabiner.NotificationWindow' \
)
echo ""
echo "*** BIG SUR GUI AGENTS ***"
for agent in "${TODISABLE[@]}"
do
    {
        echo "Booting out BIG SUR GUI Agent ${agent}"
        sudo launchctl bootout gui/501/${agent}
        #sudo launchctl disable gui/501/${agent}
    } #&> /dev/null
done

#==================================================================================================

# Big Sur System Daemons to bootout
TODISABLE=( \
'com.apple.analyticsd' \
'com.apple.appleseed.fbahelperd' \
'com.apple.apsd' \
'com.apple.backupd' \
'com.apple.backupd-helper' \
'com.apple.cloudd' \
'com.apple.CommCenterRootHelper' \
'com.apple.eapolcfg_auth' \
'com.apple.familycontrols' \
'com.apple.findmymacd' \
'com.apple.findmymacmessenger' \
'com.apple.icloud.findmydeviced' \
'com.apple.icloud.searchpartyd' \
'com.apple.locationd' \
'com.apple.ManagedClient' \
'com.apple.ManagedClient.cloudconfigurationd' \
'com.apple.ManagedClient.enroll' \
'com.apple.ManagedClient.mechanism' \
'com.apple.mediaremoted' \
'com.apple.mobileassetd' \
'com.apple.netbiosd' \
'com.apple.preferences.timezone.admintool' \
'com.apple.rapportd' \
'com.apple.remoted' \
'com.apple.RemoteDesktop.PrivilegeProxy' \
'com.apple.remotemanagementd' \
'com.apple.RemotePairTool' \
'com.apple.screensharing' \
'com.apple.security.FDERecoveryAgent' \
'com.apple.siri.acousticsignature' \
'com.apple.siri.morphunassetsupdaterd' \
'com.apple.siriinferenced' \
'com.apple.softwareupdate_firstrun_tasks' \
'com.apple.softwareupdated' \
'com.apple.SubmitDiagInfo' \
'com.apple.UserNotificationCenter' \
'com.barebones.authd' \
'com.bombich.ccchelper' \
'com.docker.vmnetd' \
'com.google.keystone.daemon' \
'com.microsoft.autoupdate.helper' \
'com.microsoft.office.licensingV2.helper' \
'com.microsoft.OneDriveStandaloneUpdaterDaemon' \
'com.microsoft.OneDriveUpdaterDaemon' \
'com.paceap.eden.licensed' \
'com.vidyo.DPA.VidyoCamera' \
'org.cups.cupsd' \
'org.pqrs.karabiner.karabiner_grabber' \
'org.pqrs.karabiner.karabiner_observer' \
'org.pqrs.Karabiner-DriverKit-VirtualHIDDeviceClient' \
)
echo ""
echo "*** BIG SUR SYSTEM DAEMONS ***"
for daemon in "${TODISABLE[@]}"
do
    {
        echo "Booting out BIG SUR Library Daemon ${daemon}"
        sudo launchctl bootout system/${daemon}
        #sudo launchctl disable system/${daemon}
    } #&> /dev/null
done


#==================================================================================================

# Big Sur User Agents (1) to bootout

echo "Disabling geod"
sudo launchctl bootout user/205/com.apple.geod
#sudo launchctl disable user/205/com.apple.geod