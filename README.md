Пример использования [библиотеки](FlowKitSampleApp/Sources/FlowKit) для координации флоу.

## Цель

Не отходя от концепции координаторов флоу, библиотека пытается решить несколько связанных с ними проблем:

- Протекание логики в координатор, что приводит к распуханию и появлению лишних ответственностей
- Протекание сущностей в координатор, что приводит к появлению связанных с шареным стейтом сайд-эффектов
- Отсутствие стандартного способа переиспользовать флоу как часть другого флоу

Все эти проблемы решаются и без дополнительных библиотек, если флоу готовить правильно. Цель данной библиотеки – не давать готовить неправильно, полноценно выполняя задачу координации.

## Термины

- Шаги, ноды – составные элементы флоу, содержащию логику каких-либо действий, совершаемых при прохождении данного флоу.

## Детали реализации

Основными «строительными блоками» флоу являются типы `FlowAction` и `FlowNode`:

- [`FlowAction`](FlowKitSampleApp/Sources/FlowKit/Public/FlowAction+Then.swift) – обычные [промисы](https://en.wikipedia.org/wiki/Futures_and_promises), принимающие `FlowNode` в качестве шагов.

- [`FlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/FlowNode.swift) – абстракция, подобная `(Input) -> FlowAction<Output>`, дающая возможность строить цепочки, где `Input` предыдущего шага связан с `Output`-ом следующего. Используется для реализации *асинхронной* логики шагов. Должны быть атомарны.

- [`ValueTransformer`](FlowKitSampleApp/Sources/FlowKit/Public/ValueTransformer.swift) и [`OptionalValueTransformer`](FlowKitSampleApp/Sources/FlowKit/Public/OptionalValueTransformer.swift) – абстракции над `FlowNode`, используемая для реализации *синхронной* логики шагов. Например, маппинг одного значения в другое. Должны быть атомарны.

- [`DisposableFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/DisposableFlowNode.swift) – абстракция над `FlowNode`, используемая для реализации шагов, которые не должны повторяться. Например, когда задача не должна повторяться при повторных нажатиях на какую-либо кнопку.

- [`CancellableFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/CancellableFlowNode.swift) – абстракция над `FlowNode`, используемая для реализации шагов, которые не должны продолжаться при изменении текущего контекста. Например, когда долгая задача должна завершиться без обработки результата при уходе с текущего экрана.

- [`AnyFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/AnyFlowNode.swift) – абстракция, стирающая тип `FlowNode`. Используется, когда нужно работать не с *конкретным* `FlowNode`, а *любым*, но с конкретными `Input`-ом и `Output`-ом.

- [`Publisher`](FlowKitSampleApp/Sources/PromiseKit/Publisher.swift) – вспомогательная реализация промисов, не входящая во FlowKit, но позволяющая продемонстрировать передачу данных назад во флоу. Например, для показа лоадеров или сохранении состояния флоу при возврате на предыдущие экраны.

## Примеры решения типовых задач

**Запрет повторения шага:**

```swift
.then(CreateTransferNode(dependencies).disposable())
```

Метод `disposable` оборачивает `CreateTransferNode` в `DisposableFlowNode`.

> :warning: Чтобы `CreateTransferNode` не застрял в состоянии `busy`, `completion` в нем должен вызываться в любом случае.

**Игнорирование результата работы шага при уходе с экрана:**

```swift
.then(CreateTransferNode(dependencies).cancellable(contextProvider: contextProvider))
```

Метод `cancellable` оборачивает `CreateTransferNode` в `CancellableFlowNode`. `contextProvider` является реализацией протокола [`ContextProvider`](FlowKitSampleApp/Sources/FlowKit/Public/ContextProvider.swift), простым примером которой является [реализация, возвращающая топовый `UIViewController`](FlowKitSampleApp/Sources/TransferFlowFeature/Internal/ApplicationContextProvider.swift).

**Показ лоадеров:**

```swift
struct CreateTransferNode: FlowNode {
    func action(with input: ...) -> FlowAction<Transfer> {
        return FlowAction { completion in
            dependencies.state.loading.value = true // 1

            dependencies.repository.createTransfer(with: input) {
                dependencies.state.loading.value = false // 2
                completion(.success($0))
            }
        }
    }
}
```

1. Стартуем лоадер перед запросом. `dependencies.state.loading` является значением типа `Publisher<Bool>`, на которое подписаны презентеры экранов.
2. После заврешения запроса останавливаем лоадер.

**Ветвление с конвертацией значения и предикатами по этому значению:**

```swift
.switch(TransformAmountResultToValidity()) { $0                             // 1
    .when({ $0 == .invalid }, then: ShowInvalidAmountNode(dependencies))    // 2
    .continue()                                                             // 3
}
```

1. `TransformAmountResultToValidity` конвертирует значение `Amount` в `Validity`
2. Если `Validity` равно `invalid`, то запускаем `ShowInvalidAmountNode` с передачей ему `Amount`
3. Иначе метод `continue` возвращает `Amount`, переданное в `TransformAmountResultToValidity` перед заходом в `switch`

**Ветвление с конвертацией в опциональное значение вместо предикатов:**

```swift
.switch { $0
    .when(TransformAmountResultToTransferWithAmount(), then: ShowTariffsNode(dependencies)) // 1
    .default(TransformAmountResultToTransferWithTariff())                                   // 2
}
```

1. Если конвертер `TransformAmountResultToTransferWithAmount` не вернул `nil`, то запускаем `ShowTariffsNode` с передачей ему `Amount`
2. Иначе метод `default` взвращает значение после конвертации `TransformAmountResultToTransferWithTariff`

**Ветвление с конвертацией значения, предикатами по этому значению и конвертацией перед каждой веткой:**

```swift
.switch(TransformConfirmationResultToStep(),                            // 1
        transformer: TransformConfirmationResultToTransfer()) { $0      // 2
    .when({ $0 == .editAmount }, then: BackToAmountNode(dependencies))  // 3
    .when({ $0 == .editTariff }, then: BackToTariffsNode(dependencies)) // 4
    .continue()                                                         // 5
}
```

1. `TransformConfirmationResultToStep` конвертирует значение `ConfirmationResult` в `Step` для предикатов
2. `TransformConfirmationResultToTransfer` конвертирует значение `ConfirmationResult` в `Transfer` для веток
3. Если `Step` равен `editAmount`, то запускаем `BackToAmountNode` с передачей ему `Transfer`
4. Если `Step` равен `editTariff`, то запускаем `BackToTariffsNode` с передачей ему `Transfer`
5. Иначе метод `continue` возвращает значение `Transfer` из `TransformConfirmationResultToTransfer`

## Примеры

- [Реализация флоу](FlowKitSampleApp/Sources/TransferFlowFeature/Public/TransferFlow.swift)
- [Реализации шагов](FlowKitSampleApp/Sources/TransferFlowFeature/Internal/Nodes)
