import XCTest
import CoreData
@testable import SportingApp

class LeagueDetailsViewModelTests: XCTestCase {
    var mockPersistentContainer: NSPersistentContainer!
    var coreDataServices: CoreDataServices!
    var viewModel: LeagueDetailsViewModle!

    override func setUp() {
        super.setUp()

        mockPersistentContainer = {
            let container = NSPersistentContainer(name: "SportingApp")
            let description = NSPersistentStoreDescription()
            description.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [description]
            container.loadPersistentStores { description, error in
                if let error = error {
                    fatalError("Failed to load persistent stores: \(error)")
                }
            }
            return container
        }()

        coreDataServices = CoreDataServices(context: mockPersistentContainer.viewContext)
        viewModel = LeagueDetailsViewModle(coreDataServices: coreDataServices)
    }

    override func tearDown() {
        super.tearDown()
        viewModel = nil
        coreDataServices = nil
        mockPersistentContainer = nil
    }

 

    func testSaveLeague() {
        viewModel.saveLeague(id: 1, name: "Test League", logo: "logo.png", sport: "Football")
        XCTAssertTrue(viewModel.isLeagueSavedToCoreData(leagueId: 1))
    }

    func testRemoveLeague() {
        viewModel.saveLeague(id: 1, name: "Test League", logo: "logo.png", sport: "Football")
        viewModel.removeLeagueFromCoreData(leagueId: 1)
        XCTAssertFalse(viewModel.isLeagueSavedToCoreData(leagueId: 1))
    }
}

