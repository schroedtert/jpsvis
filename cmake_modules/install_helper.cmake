#########################################################
#                    INSTALL                            #
#########################################################
include(InstallRequiredSystemLibraries)
include(GNUInstallDirs)

INSTALL(TARGETS jpsvis
        BUNDLE DESTINATION ${CMAKE_INSTALL_PREFIX} COMPONENT Runtime
        RUNTIME DESTINATION bin COMPONENT Runtime
        )

# install Qwt and OpenCV
install(CODE "
include(BundleUtilities)
fixup_bundle(\"\${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR}/jpsvis${CMAKE_EXECUTABLE_SUFFIX}\"  \"\" \"\")
")

# NOTE: For Future Mac installer, use macdeployqt utility (think about the licenses as well)
if (WIN32)
    # Install Qt dlls
    set (WINDEPLOYQT_APP \"${Qt5Core_DIR}/../../../bin/windeployqt\")
    install(CODE "
        message(\"\${CMAKE_INSTALL_PREFIX}/jpsvis.exe\")
        execute_process(COMMAND ${WINDEPLOYQT_APP} \"\${CMAKE_INSTALL_PREFIX}/bin/jpsvis.exe\")
    ")

    # NOTE: Paths might be platform specific
    install(DIRECTORY "${Qt5Core_DIR}/../../../../../Licenses" DESTINATION "Licenses/Qt_Licenses")
endif()

install(FILES "${CMAKE_SOURCE_DIR}/ReadMe.txt" "${CMAKE_SOURCE_DIR}/LICENSE" DESTINATION ".")

##################################################################
#                         PACKAGE                                #
##################################################################

set(CPACK_PACKAGE_FILE_NAME "jpsvis-installer-${PROJECT_VERSION}")
set(CPACK_PACKAGE_VENDOR "Forschungszentrum Juelich GmbH")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERISON_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERISON_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERISON_PATCH})
set(CPACK_PACKAGE_DESCRIPTION "PeTrack is a software for the automated extraction of pedestrian trajectories from videos.")
set(CPACK_PACKAGE_DESCRIPTION_FILE "${CMAKE_SOURCE_DIR}/README.md")
set(CPACK_PACKAGE_HOMEPAGE_URL "https://www.fz-juelich.de/ias/ias-7/EN/Expertise/Software/PeTrack/petrack.html")
set(CPACK_RESOURCE_FILE_README "${CMAKE_SOURCE_DIR}/ReadMe.txt")
set(CPACK_PACKAGE_EXECUTABLES "jpsvis")
set(CPACK_MONOLITHIC_INSTALL TRUE)
set(CPACK_CREATE_DESKTOP_LINKS jpsvis)
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_SOURCE_DIR}/LICENSE")


if(WIN32)
    set(CPACK_GENERATOR "NSIS")

#    set(CPACK_NSIS_MUI_ICON "${CMAKE_SOURCE_DIR}\\\\petrack.ico")
    set(CPACK_NSIS_MODIFY_PATH ON)
    set(CPACK_NSIS_DISPLAY_NAME "JPSVis")
    set(CPACK_NSIS_PACKAGE_NAME "JPSVis")
#    set(CPACK_NSIS_INSTALLED_ICON_NAME "${CMAKE_SOURCE_DIR}\\\\petrack.ico")
    set(CPACK_NSIS_HELP_LINK "https://www.fz-juelich.de/ias/ias-7/EN/Expertise/Software/PeTrack/petrack.html")
    set(CPACK_NSIS_URL_INFO_ABOUT ${CPACK_NSIS_HELP_LINK})
    set(CPACK_NSIS_CONTACT "petrack@fz-juelich.de")
    set(CPACK_NSIS_ENABLE_UNINSTALL_BEFORE_INSTALL ON)
endif()

