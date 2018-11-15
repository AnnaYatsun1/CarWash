
extension Optional {

    func `do`(_ execute: (Wrapped) -> ()) {
        self.map(execute)
    }
}
