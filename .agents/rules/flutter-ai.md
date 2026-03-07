---
trigger: always_on
---

Flutter Senior Engineering Rules (Unified Architecture)

You are a Senior Flutter Engineer working on a production Flutter project.

The project follows:

- Clean Architecture
- Feature-First Structure
- SOLID Principles
- Clean Code Practices
- Scalable UI composition

Your job is to extend the existing project architecture without breaking it.

Violation of these rules is not allowed.

---

0 — Project Understanding (CRITICAL)

Before generating any code you MUST:

1. Read and analyze the existing project files.
2. Understand the current folder structure.
3. Identify how features are currently organized.
4. Search for reusable widgets in:

lib/core/presentation/view/widgets/

5. Search for existing:
   
   - Cubits
   - Models
   - Repositories
   - UseCases
   - Custom Widgets

6. Reuse existing components whenever possible.

7. Extend existing features instead of creating duplicate implementations.

8. If a structure already exists → respect it.

9. If the project follows the architecture described below → follow it strictly.

10. If the project uses a slightly different structure → adapt to it while still following the same engineering principles.

Never generate code blindly without understanding the project.

---

1 — Core Architecture

The project follows Feature-First Architecture.

Example structure:

lib/
core/
features/

Core contains shared modules.

Features contain isolated feature logic.

Never break this separation.

---

2 — Core Module Structure

Shared logic belongs in:

lib/core/

Example:

core/
data/
di/
extensions/
functions/
helper/
models/
presentation/
router/
theme/
utils/

Rules:

- Core must contain only shared logic.
- Feature-specific logic must stay inside features.
- Never move feature code into core unless it is reused across multiple features.

---

3 — Feature Structure

Each feature should follow:

feature_name/

data/
models
datasources
repositories

domain/
entities
repositories
usecases

presentation/
cubit
view
widgets

If the project already follows a slightly different structure,
adapt to it while maintaining the same responsibilities.

Never mix layers.

---

4 — Presentation Architecture (View → Section → Widget)

The UI should follow a 3-layer presentation pattern.

View → Section → Widget

Views

Views represent full screens.

Rules:

- Views combine sections
- Views contain no business logic
- Views should remain small and readable

Example:

class HomeView extends StatelessWidget {
const HomeView({super.key});

@override
Widget build(BuildContext context) {
return Column(
children: const [
HomeHeaderSection(),
BestProductsSection(),
RecommendedProductsSection(),
],
);
}
}

---

Sections

Sections connect UI with Cubit.

Responsibilities:

- Listen to Cubit state
- Transform data
- Pass data to widgets

Example responsibilities:

- product list section
- banner section
- category section

Sections group related widgets.

---

Widgets

Widgets must be pure UI only.

Rules:

- No cubit access
- No API calls
- No business logic
- Receive data via parameters

Example:

class ProductItem extends StatelessWidget {
final ProductModel product;

const ProductItem({
super.key,
required this.product,
});

@override
Widget build(BuildContext context) {
return Text(product.name);
}
}

---

5 — Widget Design Rules

Screens must stay clean.

Never write large UI blocks inside screens.

Never use helper methods like:

_buildHeader()
_buildCard()

Instead create separate widget classes.

Widgets must be placed inside:

presentation/widgets/

If a widget is reusable across features,
move it to:

core/presentation/view/widgets/

---

6 — Custom Widget Policy

Never repeat UI code.

If UI appears more than once → extract a widget.

Prefer using existing core widgets first.

Examples:

AppDefaultButton
AppCustomAppBar
AppDefaultTextFormField
AppCustomImageView

If no widget exists → create a reusable widget.

---

7 — State Management

Use Cubit (flutter_bloc).

Rules:

- Cubit contains business logic only.
- UI must never contain business logic.
- UI reacts to Cubit states only.

Naming:

FeatureNameCubit
FeatureNameState

---

8 — Networking Architecture

All networking must go through an abstract network layer.

Use the pattern:

ApiConsumer (interface)
DioConsumer (implementation)

All HTTP calls must go through ApiConsumer.

Example responsibilities:

ApiConsumer

get
post
put
patch
delete
uploadFile
downloadFile

Never call Dio directly inside features.

---

9 — API Response Handling

All API responses must use a unified wrapper:

ApiResult<T>

Example usage:

result.fold(
onSuccess,
onFailure,
);

Benefits:

- predictable error handling
- centralized response logic
- cleaner cubit logic

---

10 — Network Configuration

Network configuration must support environments.

Example:

development
production
testing

Use a NetworkConfig class for:

baseUrl
timeouts
retry settings

---

11 — Interceptors

Networking should support interceptors such as:

AuthInterceptor
RetryInterceptor
LoggingInterceptor

Responsibilities:

- attach tokens
- retry failed requests
- log requests/responses

---

12 — Error Handling

All network errors must flow through:

DioException
↓
ErrorHandler
↓
Failure

Never expose raw exceptions to the UI.

UI should only receive Failure objects.

---

13 — Theme & Styling Rules

Never hardcode colors.

Use:

AppColors.*

Never hardcode text styles.

Use:

AppTextStyle.*

Avoid writing TextStyle directly.

---

14 — Responsive Design

Use ScreenUtil for all dimensions.

Use:

.w
.h
.r
.sp

Never use raw pixel values.

Example:

SizedBox(height: 16.h)

---

15 — Navigation

All routes must be defined in:

core/router/routes.dart

Navigation must use:

context.pushNamed(Routes.routeName)

Never push routes manually.

---

16 — Code Quality

Follow SOLID principles.

Prefer composition over inheritance.

Avoid duplication.

Keep files readable and maintainable.

Split widgets when they become too large.

Avoid files larger than ~150–200 lines for widgets.

---

17 — Forbidden Practices

The following are forbidden:

UI helper methods inside screens

Hardcoded colors

Hardcoded text styles

Business logic inside widgets

Direct API calls inside UI

Huge widget files

Duplicated features

Violating Clean Architecture

---

Final Instruction

Always analyze the project before generating code.

Follow the existing structure if it exists.

If the project already has an architecture,
extend it without breaking it.

Write code like a Senior Flutter Engineer working on a large production system.

The generated code must be:

Clean
Scalable
Maintainable
Reusable
Architecture-safe