//
//  Untitled.swift
//  Terbit
//
//  Created by Ciko Edo Febrian on 25/03/25.
//

let constantDays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
let constantDaysInt = [1, 2, 3, 4, 5, 6, 7]

let constantMorningRoutine: [ActivityModel] = [
    ActivityModel(
          title: "Set Focus",
          desc: "Start your morning with clarity and intention. By identifying what matters most today, you create direction and purpose. This small act helps you mentally prepare and reduces the overwhelm of a scattered to-do list.",
          instructions: [
              "Write down or say your top 3 priorities for today."
          ],
          duration: 2,
          logoImage: "applepencil.and.scribble",
          images: ["SetFocus"],
          instructionDurations: [120],
          detailsImage: "DetailsSetFocus"
      ),
      ActivityModel(
          title: "Hydrate Gently",
          desc: "Drinking water or coffee first thing in the morning reawakens your body and mind. It refreshes you after a night of rest, supports digestion, and signals your system that the day is beginning.",
          instructions: [
              "Sip your water or coffee slowly and stay present with the moment."
          ],
          duration: 1,
          logoImage: "cup.and.saucer",
          images: ["Hydrate"],
          instructionDurations: [60],
          detailsImage: "DetailsHydrate"
      ),
      ActivityModel(
          title: "Stretch Your Body",
          desc: "Release the stiffness from sleep and long commutes with simple, restorative movements. A short stretch in the morning helps activate your muscles, improve posture, and invite ease into your body. These light motions can refresh your energy and prepare you to sit or stand with more comfort and awareness throughout the day.",
          instructions: [
              "Sit tall, clasp hands behind your head, and arch your back while looking up.",
              "Hold the back of a chair, bend your knees, and lower into a gentle squat.",
              "Cross your right ankle over your left knee and press the right knee down gently.",
              "Cross your left ankle over your right knee and press the left knee down gently.",
              "Tilt your head to the right, bringing your ear toward your shoulder.",
              "Tilt your head to the left, bringing your ear toward your shoulder.",
              "Reach your right arm overhead and bend gently to the left.",
              "Reach your left arm overhead and bend gently to the right."
          ],
          duration: 2,
          logoImage: "figure.strengthtraining.functional",
          images: ["StretchBack", "StretchBackAndLateral", "StretchGlutesAndAbductors", "StretchGlutesAndAbductors", "StretchNeck", "StretchNeck", "StretchOblique", "StretchOblique"],
          instructionDurations: [20, 30, 30, 20, 20, 20, 20, 20],
          detailsImage: "DetailsStretch"
//          instructionDurations: [3, 3, 3, 3, 3, 3, 3, 3]
      ),
    ActivityModel(
          title: "Mindful Breathing",
          desc: "Intentional breathing calms the mind, lowers stress, and sharpens focus. Even one minute of conscious breathwork can create a sense of balance and control as you begin your workday.",
          instructions: [
              "Inhale for 4 seconds.",
              "Hold your breath for 4 seconds.",
              "Exhale for 8 seconds.",
          ],
          duration: 2,
          logoImage: "wind",
          images: [],
          instructionDurations: [4, 4, 8],
          repeatCount: 5,
          detailsImage: "DetailsBreathing"
          
      ),
      ActivityModel(
          title: "Short Walk",
          desc: "A brief walk recharges your body and refreshes your senses. It promotes movement, supports circulation, and gives your mind space to breathe and reset before diving into tasks.",
          instructions: [
              "Walk slowly and observe your surroundings — the colors, sounds, and how your feet feel on the ground."
          ],
          duration: 3,
          logoImage: "figure.walk",
          images: ["Walk"],
          instructionDurations: [5],
          detailsImage: "DetailsWalk"
      )
]
