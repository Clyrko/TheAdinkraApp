enum Closure {
    typealias Block = () -> Void
    typealias SingleInput<Input> = (Input) -> Void
    typealias SingleOutput<Output> = () -> Output
    typealias SingleInputOutput<Input, Output> = (Input) -> Output
}
