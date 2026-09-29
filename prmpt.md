# ROLE

You are a Senior Flutter UI/UX Architect, Product Designer, Design-System Engineer, and Mobile UX Specialist.

You have access to the following skills and MUST actively use them throughout this task:

* `ui-ux-pro-max`
* `ui-styling`
* `brand`
* `banner-design`
* `ponytail`
* `flutter-best-practices`

Your mission is to completely redesign the existing Flutter application into a **premium, authentic, elegant Islamic mobile experience**.

This is NOT a simple color/theme update.

You must perform a **full visual and UX redesign of the entire application**, including every screen, dialog, bottom sheet, popup, empty state, loading state, error state, card, form, navigation element, header, banner, button, icon treatment, and reusable component.

---

# PRIMARY GOAL

Transform the application into a visually refined Islamic application that feels:

* Peaceful
* Spiritual
* Elegant
* Modern
* Premium
* Warm
* Minimal
* Comfortable for long sessions
* Authentic
* Human-designed
* Consistent
* Emotionally calming

The final result must **NOT look AI-generated**.

Avoid generic AI UI patterns, excessive gradients, excessive glassmorphism, random decorative elements, over-rounded cards, excessive shadows, neon colors, or visually noisy interfaces.

The design should feel like it was created by an experienced human product designer who understands:

* Islamic visual culture
* Arabic typography
* Modern mobile UX
* Accessibility
* Visual hierarchy
* Cultural sensitivity
* Long-session usability

---

# IMPORTANT: DO NOT BREAK THE APPLICATION

Before changing anything:

1. Inspect the complete project.
2. Understand the existing architecture.
3. Identify every screen.
4. Identify every dialog.
5. Identify every bottom sheet.
6. Identify every reusable widget.
7. Identify the navigation structure.
8. Identify the state-management architecture.
9. Identify theme/design-related files.
10. Identify duplicated UI patterns.
11. Identify inconsistent spacing, typography, colors, icons, and components.
12. Identify screens that already have good UX and preserve their functional behavior.

The redesign must NOT unnecessarily modify:

* Business logic
* API contracts
* Database logic
* Authentication logic
* State management behavior
* Navigation behavior
* Repository architecture
* Existing feature behavior

UI/UX improvements must remain compatible with the existing application architecture.

---

# PHASE 1 — COMPLETE PROJECT AUDIT

Before writing or modifying code, perform a complete UI audit.

Create an internal inventory containing:

## Screens

For every screen document:

* Screen name
* Route
* Purpose
* Main components
* Current UX problems
* Current visual problems
* Recommended redesign
* Reusable components that can be extracted

## Dialogs

Find EVERY:

* AlertDialog
* Dialog
* showDialog
* showModalBottomSheet
* BottomSheet
* PopupMenu
* Menu
* Confirmation dialog
* Permission dialog
* Error dialog
* Success dialog
* Custom modal
* Date/time picker
* Selection modal

Every one of them must be reviewed and redesigned.

## States

Also inspect:

* Loading
* Empty
* Error
* Offline
* Success
* Skeleton
* Disabled
* No-data
* First-use states

Do not redesign only the "happy path".

---

# PHASE 2 — CREATE A REAL DESIGN SYSTEM

Do NOT style every screen independently.

First create a centralized design system.

The design system should define:

## Colors

Create a carefully balanced Islamic-inspired palette.

Do NOT use stereotypical "green everywhere".

Use a sophisticated combination of:

* Deep primary tone
* Warm neutral surfaces
* Soft cream / parchment tones
* Subtle botanical or olive-inspired secondary tones
* Elegant gold/brass accent used sparingly
* Dark mode equivalents

The palette must maintain excellent contrast and accessibility.

Avoid:

* Neon green
* Extremely saturated colors
* Pure black everywhere
* Excessive gold
* Too many accent colors

---

# TYPOGRAPHY

Typography is extremely important.

The application supports Arabic and English.

Design a typography system that handles:

* Arabic headings
* Arabic body text
* English headings
* English body text
* Numbers
* Quranic text if applicable
* Tasbih / counters
* Labels
* Buttons
* Dialog text
* Navigation labels

Arabic typography must feel intentional and elegant.

Do not use random fonts.

Define a consistent hierarchy such as:

* Display
* H1
* H2
* H3
* Body Large
* Body
* Body Small
* Caption
* Button
* Label
* Numeric / Counter

Pay particular attention to:

* Arabic line height
* Letter spacing
* Baseline alignment
* RTL layout
* Quranic text readability

---

# SPACING SYSTEM

Create a consistent spacing scale.

For example:

4
8
12
16
20
24
32
40
48

Do not randomly use arbitrary padding values throughout the application.

---

# CORNER RADIUS

Use a consistent radius system.

Avoid making every element extremely rounded.

Use different radius levels for:

* Cards
* Buttons
* Inputs
* Dialogs
* Bottom sheets
* Chips
* Containers

The interface should feel refined rather than childish.

---

# SHADOWS & ELEVATION

Use subtle elevation.

Avoid:

* Huge shadows
* Strong black shadows
* Floating everything
* Excessive depth

Prefer:

* Soft elevation
* Subtle borders
* Tonal surfaces
* Controlled contrast

---

# ICONOGRAPHY

Review the entire icon system.

Use a consistent icon language.

Do not mix:

* Material icons
* Random SVG icons
* Emoji
* Different icon styles

unless there is a deliberate design reason.

Islamic decorative icons must remain subtle.

Avoid cliché decorative usage of:

* Crescent moons everywhere
* Mosques everywhere
* Arabic calligraphy everywhere
* Random Islamic patterns

Use them only where they improve the visual identity.

---

# PHASE 3 — ISLAMIC VISUAL IDENTITY

Create an Islamic visual identity that is:

Elegant rather than stereotypical.

The visual language can be inspired by:

* Islamic geometric patterns
* Subtle arabesque motifs
* Architectural proportions
* Natural textures
* Soft parchment
* Traditional manuscript aesthetics
* Geometric symmetry
* Subtle botanical elements
* Refined calligraphic influence

However:

DO NOT make the app look like an old religious website.

The goal is:

Modern Islamic Design.

Not:

Traditional website design.

Use decorative elements as supporting details rather than the main UI.

---

# PHASE 4 — REDESIGN EVERY SCREEN

Every screen must receive a proper redesign.

For each screen:

1. Improve information hierarchy.
2. Improve spacing.
3. Improve typography.
4. Improve navigation.
5. Improve touch targets.
6. Improve readability.
7. Improve visual hierarchy.
8. Improve empty states.
9. Improve loading states.
10. Improve error states.
11. Improve animations.
12. Improve RTL behavior.
13. Improve dark mode.
14. Improve accessibility.

Do not simply wrap the existing widgets in new containers.

Reconsider the composition of each screen.

---

# HOME SCREEN

Redesign the home screen as the primary spiritual hub.

It should immediately communicate:

* Calm
* Clarity
* Islamic identity
* Personal relevance

Avoid overcrowding the home screen.

Use strong hierarchy.

Potential structure:

1. Elegant greeting / contextual header
2. Relevant daily content
3. Primary worship shortcuts
4. Featured content
5. Daily reminder
6. Secondary utilities

But do NOT blindly follow this structure.

Inspect the actual application features and design around them.

---

# QURAN / QURANIC CONTENT

If the application contains Quran functionality:

Prioritize readability over decoration.

The Quran screen must feel:

* Calm
* Respectful
* Focused
* Highly readable

Avoid excessive UI around Quranic text.

Provide clear hierarchy between:

* Surah
* Ayah
* Translation
* Tafsir
* Metadata

Use appropriate spacing and typography.

---

# AZKAR

If the application contains Azkar:

Design it for long reading sessions.

Prioritize:

* Large readable Arabic text
* Clear hierarchy
* Comfortable spacing
* Progress indication
* Easy interaction
* Minimal distractions

The user should never feel visually overwhelmed.

---

# TASBIH

If the application contains Tasbih:

Make the interaction extremely clear and satisfying.

Prioritize:

* Large central counter
* Strong touch target
* Clear progress
* Minimal distractions
* Haptic feedback where appropriate
* Elegant animations
* Easy reset
* Session state

The counter should be the visual focus.

---

# QIBLAH

If the application contains Qiblah functionality:

Design the compass/indicator as a premium focused experience.

Avoid unnecessary UI around the compass.

Use clear:

* Direction
* Degrees
* Location state
* Calibration state
* Permission state

Provide elegant feedback when the Qiblah direction is aligned.

---

# PHASE 5 — EVERY DIALOG MUST BE REDESIGNED

This is mandatory.

Search the entire project for all dialogs.

Every dialog must follow a unified design language.

Dialogs should have:

* Clear title
* Clear description
* Correct hierarchy
* Appropriate icon
* Primary action
* Secondary action
* Proper spacing
* Correct RTL behavior
* Comfortable touch targets

Do NOT use generic Flutter AlertDialog styling.

Create reusable dialog components where appropriate.

Examples:

* AppAlertDialog
* AppConfirmationDialog
* AppErrorDialog
* AppSuccessDialog
* AppInfoDialog
* AppPermissionDialog

Do not create abstractions that are unnecessary.

Follow `ponytail` principles:

* YAGNI
* Minimal abstraction
* Avoid over-engineering
* Reuse only when repetition is real

---

# PHASE 6 — BOTTOM SHEETS

Redesign every bottom sheet.

They must feel like part of the same design system.

Use:

* Proper drag handle
* Correct radius
* Correct surface color
* Clear hierarchy
* Proper safe-area handling
* Keyboard-aware behavior
* RTL support

Avoid giant rounded sheets that look like generic AI UI.

---

# PHASE 7 — NAVIGATION

Review:

* Bottom navigation
* Navigation rail if present
* App bars
* Back buttons
* Tabs
* Nested navigation

Navigation should be:

* Predictable
* Minimal
* Comfortable
* Accessible
* Visually consistent

Do not add navigation elements simply for visual purposes.

---

# PHASE 8 — MICRO-INTERACTIONS

Add subtle meaningful animations.

Examples:

* Screen transitions
* Button feedback
* Counter changes
* Selection states
* Progress transitions
* Bottom sheet transitions
* Card interactions
* Success feedback

Animations must be:

* Fast
* Subtle
* Purposeful
* Respectful

Avoid:

* Excessive bouncing
* Slow transitions
* Flashy animations
* Random motion

Respect reduced-motion accessibility where applicable.

---

# PHASE 9 — DARK MODE

If dark mode exists, redesign it properly.

Do NOT simply invert colors.

Create a real dark theme.

Dark mode should use:

* Dark surfaces
* Appropriate contrast
* Muted accents
* Reduced visual glare
* Correct elevation
* Correct text hierarchy

The dark theme should feel intentional and premium.

---

# PHASE 10 — RESPONSIVENESS

Review the UI across:

* Small phones
* Standard phones
* Large phones
* Tablets

Make sure:

* No overflow
* No clipped Arabic text
* No tiny buttons
* No excessive empty space
* No hardcoded screen dimensions

Use Flutter's responsive layout mechanisms appropriately.

---

# PHASE 11 — ACCESSIBILITY

Ensure:

* WCAG-conscious contrast
* Minimum comfortable touch targets
* Semantic labels
* Screen-reader-friendly controls
* Dynamic text scaling
* RTL correctness
* Reduced motion support
* Keyboard/focus support where relevant

Do not sacrifice accessibility for aesthetics.

---

# PHASE 12 — PERFORMANCE

Use `flutter-best-practices`.

The redesign must not introduce performance problems.

Avoid:

* Unnecessary rebuilds
* Huge widget trees
* Repeated expensive calculations
* Unnecessary animations
* Excessive opacity layers
* Excessive BackdropFilter usage
* Heavy shaders
* Unnecessary image decoding
* Memory-heavy decorative assets

Use `const` constructors wherever appropriate.

Preserve existing state-management performance.

Do not rebuild entire screens when only a small section changes.

---

# PHASE 13 — COMPONENT ARCHITECTURE

Identify repeated UI patterns and extract only genuinely reusable components.

Examples:

* AppButton
* AppCard
* AppTextField
* AppDialog
* AppBottomSheet
* SectionHeader
* EmptyState
* ErrorState
* LoadingState
* IslamicPattern
* AppBadge
* AppIconButton

However:

DO NOT create hundreds of tiny components.

Follow:

> Reuse real patterns, not hypothetical patterns.

Keep components understandable and maintainable.

---

# PHASE 14 — BRAND SYSTEM

Use the `brand` skill to establish a coherent identity.

Define:

* Brand personality
* Visual language
* Color tokens
* Typography
* Iconography
* Spacing
* Shape language
* Motion language
* Decorative language

The entire application must feel like ONE product.

A user should never feel that different screens were designed by different people.

---

# PHASE 15 — BANNERS & VISUAL CONTENT

Use `banner-design` where banners or promotional/featured sections exist.

Banners must have:

* Clear hierarchy
* Strong readability
* Controlled imagery
* Appropriate contrast
* Minimal text
* Proper CTA placement

Avoid generic AI-generated banner compositions.

Do not overcrowd banners with:

* Text
* Gradients
* Decorative shapes
* Icons
* Buttons

---

# PHASE 16 — AI-DESIGN AVOIDANCE RULES

This is extremely important.

The application must NOT look AI-generated.

Avoid these common AI UI patterns:

❌ Excessive glassmorphism
❌ Huge rounded cards
❌ Excessive gradients
❌ Neon green/purple gradients
❌ Excessive floating cards
❌ Random blobs
❌ Excessive decorative Islamic motifs
❌ Random stars
❌ Excessive shadows
❌ Every section inside a card
❌ Overuse of pills
❌ Giant typography everywhere
❌ Too many icons
❌ Too many animations
❌ Excessive whitespace without purpose
❌ Generic "dashboard" layouts
❌ Random gradient backgrounds
❌ Copying trendy Dribbble designs
❌ Making every element visually special

Instead prioritize:

✓ Strong hierarchy
✓ Calm composition
✓ Real usability
✓ Consistent spacing
✓ Intentional typography
✓ Restrained decoration
✓ Human visual judgment
✓ Cultural authenticity
✓ Accessibility
✓ Functional clarity

---

# PHASE 17 — IMPLEMENTATION RULES

Before implementing each screen:

1. Understand the existing screen.
2. Identify reusable components.
3. Define the desired hierarchy.
4. Implement the design.
5. Verify RTL.
6. Verify dark mode.
7. Verify small screens.
8. Verify accessibility.
9. Verify performance.
10. Remove unnecessary complexity.

Do not blindly rewrite files.

Prefer incremental, controlled changes.

---

# PHASE 18 — CODE QUALITY

Follow:

* Existing project architecture
* Flutter best practices
* Existing state-management conventions
* Existing dependency choices
* Existing naming conventions

Do not introduce a new architecture unless the existing architecture is genuinely preventing the redesign.

Do not add dependencies unless there is a strong technical reason.

Avoid unnecessary packages.

Avoid unnecessary abstractions.

Keep the code simple.

---

# PHASE 19 — VISUAL QA

After implementation, inspect EVERY screen.

Do not assume the redesign is correct because the application compiles.

Perform a visual QA pass for:

* Alignment
* Spacing
* Typography
* RTL
* Colors
* Contrast
* Icons
* Dialogs
* Bottom sheets
* Loading states
* Error states
* Empty states
* Animations
* Navigation
* Dark mode
* Small screens
* Large screens

Fix issues you discover.

---

# PHASE 20 — FINAL AUDIT

At the end, verify:

## UI

* Every screen redesigned
* Every dialog redesigned
* Every bottom sheet redesigned
* Every popup reviewed
* Every reusable component reviewed
* Every state reviewed

## UX

* Navigation is consistent
* Touch targets are comfortable
* Information hierarchy is clear
* Arabic UX is correct
* English UX is correct
* RTL is correct

## Design

* Islamic identity is consistent
* Typography is consistent
* Colors are consistent
* Spacing is consistent
* Radius is consistent
* Iconography is consistent
* Motion is consistent

## Technical

* No unnecessary dependencies
* No broken functionality
* No architecture regression
* No unnecessary rebuilds
* No obvious performance regressions
* No analyzer errors
* No lint errors
* No compilation errors

---

# EXECUTION STRATEGY

DO NOT attempt to redesign the entire application blindly in one pass.

Work PHASE BY PHASE.

For each phase:

1. Inspect.
2. Plan.
3. Implement.
4. Verify.
5. Fix issues.
6. Continue only after the current phase is stable.

Maintain a progress checklist.

Example:

[ ] Phase 1 — Complete UI Audit
[ ] Phase 2 — Design System
[ ] Phase 3 — Islamic Visual Identity
[ ] Phase 4 — Screen Redesign
[ ] Phase 5 — Dialog Redesign
[ ] Phase 6 — Bottom Sheets
[ ] Phase 7 — Navigation
[ ] Phase 8 — Micro-interactions
[ ] Phase 9 — Dark Mode
[ ] Phase 10 — Responsiveness
[ ] Phase 11 — Accessibility
[ ] Phase 12 — Performance
[ ] Phase 13 — Components
[ ] Phase 14 — Brand System
[ ] Phase 15 — Banners
[ ] Phase 16 — AI-design Avoidance
[ ] Phase 17 — Implementation Cleanup
[ ] Phase 18 — Code Quality
[ ] Phase 19 — Visual QA
[ ] Phase 20 — Final Audit

---

# CRITICAL RULE

DO NOT stop after creating a plan.

The objective is to actually inspect and modify the project.

Do not merely tell me what should be changed.

IMPLEMENT THE CHANGES.

Do not ask for confirmation between phases unless a decision would materially affect existing functionality or data.

If you encounter ambiguity, inspect the existing code and choose the least invasive solution consistent with the existing architecture.

---

# FINAL REQUIREMENT

The final application should feel like:

> A premium Islamic mobile product designed by an experienced human product-design team.

NOT:

> A generic Flutter application with an Islamic color palette.

Every visual decision must have a reason.

Every decorative element must earn its place.

Every interaction must feel intentional.

Every screen must belong to the same design system.

Use the available skills aggressively, but combine them with professional human design judgment.

START WITH THE COMPLETE PROJECT AUDIT AND THEN EXECUTE THE REDESIGN PHASE BY PHASE.
