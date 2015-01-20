import Cocoa

class TableViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var tableView: TableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func numberOfRowsInTableView() -> Int {
        let numberOfRows: Int = getDataArray().count
        return numberOfRows
    }
    
    func tableView(tableView: TableView!, objectValueForTableColumn tableColumn: NSTableColumn!, row: Int) -> AnyObject! {
        let headers: (AnyObject?) = getDataArray().objectAtIndex(row).objectForKey(tableColumn.identifier)
        return headers
    }
    
    func getDataArray () -> NSArray{
        var dataArray: [NSDictionary] = [
            ["FirstName": "Debasis", "LastName": "Das"],
            ["FirstName": "Nishant", "LastName": "Singh"],
            ["FirstName": "John", "LastName": "Doe"],
            ["FirstName": "Jane", "LastName": "Doe"],
            ["FirstName": "Mary", "LastName": "Jane"]
        ];
        println(dataArray);
        return dataArray;
    }
}
