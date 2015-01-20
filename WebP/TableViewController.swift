import Cocoa

class TableViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: TableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        let numberOfRows: Int = getDataArray().count
        return numberOfRows
    }
    
    func tableView(tableView: NSTableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject! {
        println("tableViewDelegate")
        return getDataArray().objectAtIndex(row).objectForKey(tableColumn.identifier)
    }
    
    func getDataArray () -> NSArray{
        var dataArray: [NSDictionary] = [
            ["FirstName": "Debasis", "LastName": "Das"],
            ["FirstName": "Nishant", "LastName": "Singh"],
            ["FirstName": "John", "LastName": "Doe"],
            ["FirstName": "Jane", "LastName": "Doe"],
            ["FirstName": "Mary", "LastName": "Jane"]
        ];
        return dataArray;
    }
}
