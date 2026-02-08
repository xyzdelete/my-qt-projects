let db

export function dbInit(LocalStorage) {
  print("Initializing database...")
  db = LocalStorage.openDatabaseSync("sqlitedemodb", "1.0", "SQLite Demo database", 1024)
  db.transaction(function(tx){
    tx.executeSql('CREATE TABLE IF NOT EXISTS sqlitedemotable(name TEXT, value TEXT)')
  })
}

export function storeData(rectId) {
  print("Storing data...")

  // Check if the database was ever created
  if(!db) {
    return
  }

  db.transaction(function(tx){
    // Check if sqlitedemo entry is available in database table
    var result = tx.executeSql('SELECT * from sqlitedemotable where name="sqlitedemo"')

    // Prepare json object data from qml code
    var obj = {
      colorred: rectId.color.r,
      colorgreen: rectId.color.g,
      colorblue: rectId.color.b
    }

    if (result.rows.length === 1) {
      // Update
      print("Updating database table entry...")
      result = tx.executeSql('UPDATE sqlitedemotable set value=? where name="sqlitedemo"', [JSON.stringify(obj)])
    } else {
      // Create entry
      print("Creating new database table entry...")
      result = tx.executeSql('INSERT INTO sqlitedemotable VALUES (?,?)', ['sqlitedemo', JSON.stringify(obj)])
    }
  })
}

export function readData(rectId) {
  print("Reading data from database...")

  if (!db) {
    return;
  }

  db.transaction(function(tx) {
    var result = tx.executeSql('SELECT * FROM sqlitedemotable where name="sqlitedemo"')

    if (result.rows.length === 1)
    {
      // We have data that we can work with

      // get the value column
      var value = result.rows[0].value
      // convert to JS object
      var obj = JSON.parse(value)

      // apply to object
      rectId.color = Qt.rgba(obj.colorred, obj.colorgreen, obj.colorblue, 1)
    }
  })
}