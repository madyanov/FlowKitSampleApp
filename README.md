## DEPRECATED

See https://github.com/madyanov/FlowKit

## Цель

Не отходя от концепции координаторов флоу, библиотека пытается решить несколько связанных с ними проблем:

- Протекание логики в координатор, что приводит к распуханию и появлению лишних ответственностей
- Протекание сущностей в координатор, что приводит к появлению связанных с шареным стейтом сайд-эффектов
- Отсутствие стандартного способа переиспользовать флоу как часть другого флоу

Все эти проблемы решаются и без дополнительных библиотек, если флоу готовить правильно. Цель данной библиотеки – не давать готовить неправильно, полноценно выполняя задачу координации.

## Термины

- Шаги, ноды, узлы – составные элементы флоу, содержащию логику каких-либо действий, совершаемых при прохождении флоу.

## Детали реализации

Основными «строительными блоками» флоу являются типы `FlowAction` и `FlowNode`:

- [`FlowAction`](FlowKitSampleApp/Sources/FlowKit/Public/FlowAction+Then.swift) – обычные [промисы](https://en.wikipedia.org/wiki/Futures_and_promises), принимающие `FlowNode` в качестве шагов.

- [`FlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/FlowNode.swift) и [`OptionalFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/OptionalFlowNode.swift) – абстракции, подобные `(Input) -> FlowAction<Output>`, дающие возможность строить цепочки, где `Input` предыдущего шага связан с `Output`-ом следующего. Используются для реализации *асинхронной* логики шагов. Должны быть атомарны.

- [`InputTransformer`](FlowKitSampleApp/Sources/FlowKit/Public/InputTransformer.swift) и [`OptionalInputTransformer`](FlowKitSampleApp/Sources/FlowKit/Public/OptionalInputTransformer.swift) – абстракции над `FlowNode`, используемые для реализации *синхронной* логики шагов. Например, для тансформация одного значения в другое. Должны быть атомарны.

- [`DisposableFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/DisposableFlowNode.swift) – обертка для нод, задачи которых не должны повторяться, пока текущая не завершена. Например, когда задача не должна повторяться при повторном взаимодействии пользователя с интерфейсом.

- [`CancellableFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/CancellableFlowNode.swift) – обертка для нод, задачи которых не должны продолжаться при изменении текущего контекста. Например, когда долгая задача должна завершиться без обработки результата при уходе с текущего экрана.

- [`AnyFlowNode`](FlowKitSampleApp/Sources/FlowKit/Public/AnyFlowNode.swift) – обертка для нод, стирающая их тип. Используется, когда нужно работать не с *конкретным* `FlowNode`, а *любым*, с соответствующими `Input`-ом и `Output`-ом.

- [`Publisher`](FlowKitSampleApp/Sources/PromiseKit/Publisher.swift) – вспомогательная реализация нотификатора/холдера, не входящая во FlowKit, позволяющая продемонстрировать передачу данных назад во флоу. Используется для показа лоадеров, сохранении состояния при возврате на предыдущие экраны и т.п.

## Примеры

- [Реализация флоу](FlowKitSampleApp/Sources/TransferFlowFeature/Public/TransferFlow.swift)
- [Реализации шагов](FlowKitSampleApp/Sources/TransferFlowFeature/Internal/Nodes)

## Принципы

- `FlowNode` должны быть атомарными. Не должны содержать координирующей логики (если `FlowNode` не является реализацией флоу), не должны иметь более одной операции навигации.
- Использовать шареный стейт разрешается только для передачи данных назад во флоу. Для передачи вперед нужно использовать трансформацию и передачу через `completion` шагов.
- Чтобы `DisposableFlowNode` не застрял в состоянии `busy`, `completion` в нем должен вызываться в любом случае.
- Предикаты в ветвлениях должны быть максимально простыми, в 1 строчку.
