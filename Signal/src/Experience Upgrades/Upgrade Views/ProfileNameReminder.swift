//
//  Copyright (c) 2020 Open Whisper Systems. All rights reserved.
//

import Foundation
import Lottie

class ProfileNameReminderMegaphone: MegaphoneView {
    init(experienceUpgrade: ExperienceUpgrade, fromViewController: UIViewController) {
        super.init(experienceUpgrade: experienceUpgrade)

        let hasProfileNameAlready = OWSProfileManager.shared().localFullName()?.isEmpty == false

        titleText = hasProfileNameAlready
            ? NSLocalizedString("REQUIRE_PROFILE_NAMES_MEGAPHONE_HAS_NAME_TITLE",
                                comment: "Title for required profile name megaphone when user already has a profile name")
            : NSLocalizedString("REQUIRE_PROFILE_NAMES_MEGAPHONE_NO_NAME_TITLE",
                                comment: "Title for required profile name megaphone when user doesn't have a profile name")
        bodyText = hasProfileNameAlready
            ? NSLocalizedString("REQUIRE_PROFILE_NAMES_MEGAPHONE_HAS_NAME_BODY",
                                comment: "Body for required profile name megaphone when user already has a profile name")
            : NSLocalizedString("REQUIRE_PROFILE_NAMES_MEGAPHONE_NO_NAME_BODY",
                                comment: "Body for required profile name megaphone when user doesn't have a profile name")
        imageName = "profileMegaphone"

        let primaryButton = MegaphoneView.Button(
            title: NSLocalizedString("REQUIRE_PROFILE_NAMES_MEGAPHONE_ACTION",
                                     comment: "Action text for required profile name megaphone")
        ) { [weak self] in
            let vc = ProfileViewController.forExperienceUpgrade {
                self?.markAsComplete()
                fromViewController.navigationController?.popToViewController(fromViewController, animated: true) {
                    fromViewController.navigationController?.setNavigationBarHidden(false, animated: false)
                    self?.dismiss(animated: false)
                    self?.presentToast(
                        text: NSLocalizedString("REQUIRE_PROFILE_NAMES_MEGAPHONE_TOAST",
                                                comment: "Toast indicating that a PIN has been created."),
                        fromViewController: fromViewController
                    )
                }
            }

            fromViewController.navigationController?.pushViewController(vc, animated: true)
        }

        let secondaryButton = snoozeButton(fromViewController: fromViewController)
        setButtons(primary: primaryButton, secondary: secondaryButton)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
