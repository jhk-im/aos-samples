# provider_overview_05

## Provider extension methods

* context.read`<`T`>` -> T
  * Provider.of`<`T`>`(context, listen: false)

* context.watch`<`T`>` -> T
  * Provider.of`<`T`>`(context)

* context.select`<`T, R`>`(R selector(T value)) -> R
  * context.select`<`Dog, String`>`((Dog dog) => dog.name)
  * listen하고싶은 필드만 특정할 수 있음
