
extension Optional {

    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
    
    func apply<Result>(_ transform: ((Wrapped) -> Result)?) -> Result? {
        return self.flatMap { transform?($0) }
    }
}
