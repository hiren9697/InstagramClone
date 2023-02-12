//
//  AsynchronousOperation.swift
//  Twitter
//
//  Created by Hiren Faldu Solution on 23/07/22.
//

import Foundation

class AsynchronousOperation: Operation {
    
    override var isConcurrent: Bool {
        return true
    }
    
    /// State for this operation.
    
    @objc private enum OperationState: Int {
        case ready
        case executing
        case finished
    }
    
    /// Concurrent queue for synchronizing access to `state`.
    
    private let stateQueue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".rw.state", attributes: .concurrent)
    
    /// Private backing stored property for `state`.
    
    private var rawState: OperationState = .ready
//    {
//        willSet {
//            // New Value
//            let newState: String
//            switch newValue {
//            case .ready:
//                newState = "isReady"
//                break
//            case .executing:
//                newState = "isExecuting"
//                break
//            case .finished:
//                newState = "isFinished"
//                break
//            }
//            // Current Value
//            let currentState: String
//            switch rawState {
//            case .ready:
//                currentState = "isReady"
//                break
//            case .executing:
//                currentState = "isExecuting"
//                break
//            case .finished:
//                currentState = "isFinished"
//                break
//            }
//            willChangeValue(forKey: currentState)
//            willChangeValue(forKey: newState)
//        }
//        didSet {
//            // Old Value
//            let oldState: String
//            switch oldValue {
//            case .ready:
//                oldState = "isReady"
//                break
//            case .executing:
//                oldState = "isExecuting"
//                break
//            case .finished:
//                oldState = "isFinished"
//                break
//            }
//            // Current Value
//            let currentState: String
//            switch rawState {
//            case .ready:
//                currentState = "isReady"
//                break
//            case .executing:
//                currentState = "isExecuting"
//                break
//            case .finished:
//                currentState = "isFinished"
//                break
//            }
//            didChangeValue(forKey: currentState)
//            didChangeValue(forKey: oldState)
//        }
//    }
    
    /// The state of the operation
    
    @objc private dynamic var state: OperationState {
        get { return stateQueue.sync { rawState } }
        set { stateQueue.sync(flags: .barrier) { rawState = newValue } }
    }
    
    // MARK: - Various `Operation` properties
    
    open         override var isReady:        Bool { return state == .ready && super.isReady }
    public final override var isExecuting:    Bool { return state == .executing }
    public final override var isFinished:     Bool { return state == .finished }
    
    // KVO for dependent properties
    
    open override class func keyPathsForValuesAffectingValue(forKey key: String) -> Set<String> {
        if ["isReady", "isFinished", "isExecuting"].contains(key) {
            return [#keyPath(state)]
        }
        return super.keyPathsForValuesAffectingValue(forKey: key)
    }
    
    // Start
    
    public final override func start() {
        if isCancelled {
            finish()
            return
        }
        
        state = .executing
        
        main()
    }
    
    /// Subclasses must implement this to perform their work and they must not call `super`. The default implementation of this function throws an exception.
    
    open override func main() {
        fatalError("Subclasses must implement `main`.")
    }
    
    /// Call this function to finish an operation that is currently executing
    
    public final func finish() {
        if !isFinished { state = .finished }
    }
}

/// Asynchronous Operation subclass for downloading
class DownloadOperation : AsynchronousOperation {
    let task: URLSessionTask
    
    init(session: URLSession, url: URL) {
        task = session.downloadTask(with: url)
        super.init()
    }
    
    override func cancel() {
        task.cancel()
        super.cancel()
    }
    
    override func main() {
        task.resume()
    }
}

/// Asynchronous Operation subclass for downloading
//class DownloadUserOperation : AsynchronousOperation {
//    let service = UserService()
//    let id: String
//    let completion: ResultCallback
//    
//    init(id: String,
//         completion: @escaping ResultCallback) {
//        self.id = id
//        self.completion = completion
//        super.init()
//    }
//    
//    override func cancel() {
//        super.cancel()
//    }
//    
//    override func main() {
//        service.getUserData(id: id) {[weak self] result in
//            guard let strongSelf = self else { return }
//            defer { strongSelf.finish() }
//            switch result {
//            case .success(let anyData):
//                if let user = anyData as? User {
//                    strongSelf.completion(.success(user))
//                } else {
//                    let error = NSError(domain: String(describing: self),
//                                        code: 0,
//                                        userInfo: [NSLocalizedDescriptionKey : "Couldn't download user"])
//                    Log.error("Error in downloading user")
//                    strongSelf.completion(.failure(error))
//                }
//                break
//            case .failure(let error):
//                Log.error("Error in fetching tweet' user: \(error.localizedDescription)")
//            }
//        }
//    }
//}
//
//
//class UserDownloadManager: NSObject {
//    
//    /// Dictionary of operations, keyed by the `taskIdentifier` of the `URLSessionTask`
//    
//    fileprivate var operations = [String: DownloadUserOperation]()
//    
//    /// Serial OperationQueue for downloads
//    
//    private let queue: OperationQueue = {
//        let _queue = OperationQueue()
//        _queue.name = "download"
//        _queue.maxConcurrentOperationCount = 5    // I'd usually use values like 3 or 4 for performance reasons, but OP asked about downloading one at a time
//        
//        return _queue
//    }()
//    
//    /// Delegate-based `URLSession` for DownloadManager
//    
//    
//    /// Add download
//    ///
//    /// - parameter URL:  The URL of the file to be downloaded
//    ///
//    /// - returns:        The DownloadOperation of the operation that was queued
//    
//    @discardableResult
//    func queueDownload(_ id: String, completion: @escaping ResultCallback) -> DownloadUserOperation {
//        let operation = DownloadUserOperation(id: id,
//                                              completion: completion)
//        operations[operation.id] = operation
//        queue.addOperation(operation)
//        return operation
//    }
//    
//    /// Cancel all queued operations
//    
//    func cancelAll() {
//        queue.cancelAllOperations()
//    }
//    
//}
