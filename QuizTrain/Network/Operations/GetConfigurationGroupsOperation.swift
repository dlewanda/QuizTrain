import Foundation

class GetConfigurationGroupsOperation: AsyncOperation {

    // MARK: Properties

    private weak var _api: ObjectAPI?
    var api: ObjectAPI? { return _api }
    let projectId: Project.Id

    // MARK: Init

    init(api: ObjectAPI, projectId: Project.Id) {
        self._api = api
        self.projectId = projectId
    }

    // MARK: Execution

    override func start() {

        guard isCancelled == false else {
            state = .finished
            return
        }

        guard let api = api else {
            cancel()
            state = .finished
            return
        }

        state = .executing

        api.getConfigurationGroups(inProjectWithId: projectId) { [weak self] (outcome) in
            self?._outcome = outcome
            self?.state = .finished
        }
    }

    // MARK: Completion

    private var _outcome: Outcome<[ConfigurationGroup], ObjectAPI.GetError>?
    var outcome: Outcome<[ConfigurationGroup], ObjectAPI.GetError>? { return _outcome }

}
