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

- [`CancellableFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/CancellableFlowNode.swift) – абстракция над `FlowNode`, используемая для реализации шагов, которые не должны продолжаться при изменении текущего контекста. Например, когда долгая задача должна завершиться при возврате с текущего экрана назад.

- [`AnyFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/AnyFlowNode.swift) – абстракция, стирающая тип `FlowNode`. Используется, когда нужно вернуть не *конкретный* `FlowNode`, а *любой*, но с конкретными `Input`-ом и `Output`-ом.

## Примеры

- [Пример флоу](FlowKitSampleApp/Sources/TransferFlowFeature/Public/TransferFlow.swift)
- [Примеры реализации шагов](FlowKitSampleApp/Sources/TransferFlowFeature/Internal/Nodes)
