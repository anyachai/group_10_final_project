class SaveSelect {
  Table savesTable;
  TableRow rower;
  String fileName;
  SaveButton save1;
  SaveButton save2;
  SaveButton save3;
  Boolean onScreen;
  Saves currentSave;
  NameEntry nameScreen;
  Toggle playing;
  PauseScreen pauseScreen;
  
  SaveSelect (String fileName, Saves currentSave, NameEntry nameScreen, Toggle playing, PauseScreen pauseScreen) {
    this.fileName = fileName;
    this.savesTable = loadTable(fileName,"header,csv");
    updateButtons();
    this.onScreen = false;
    this.currentSave = currentSave;
    this.nameScreen = nameScreen;
    this.playing = playing;
    this.pauseScreen = pauseScreen;
  }
  
  void resetSaves() {
    savesTable = new Table();
    savesTable.addColumn("saveNum");
    savesTable.addColumn("level");
    savesTable.addColumn("name");
    savesTable.addColumn("new");
    for (int i = 0; i < 3; i++) {
      TableRow newRow = savesTable.addRow();
      newRow.setInt("saveNum", i + 1);
      newRow.setString("name", "EMPTY");
      newRow.setInt("level", 1);
      newRow.setInt("new", 1);
    }
    saveTable(savesTable, fileName);
    updateButtons();
  }
  
  void updateButtons() {
    TableRow row = savesTable.getRow(0);
    this.save1 = new SaveButton(new PVector(250, 175), color(0), color(255), new Saves(row.getString("name"), row.getInt("level"), row.getInt("saveNum")));
    row = savesTable.getRow(1);
    this.save2 = new SaveButton(new PVector(250, 300), color(0), color(255), new Saves(row.getString("name"), row.getInt("level"), row.getInt("saveNum")));
    row = savesTable.getRow(2);
    this.save3 = new SaveButton(new PVector(250, 425), color(0), color(255), new Saves(row.getString("name"), row.getInt("level"), row.getInt("saveNum")));
  }
  
  void mouseInteract() {
    if (onScreen) {
      if (save1.isInside()) {
        rower = savesTable.getRow(0);
        if (rower.getInt("new") != 1) {
          currentSave = new Saves(rower.getString("name"), rower.getInt("level"), rower.getInt("saveNum"));
          onScreen = false;
          playing.toggled = true;
          pauseScreen.started = true;
        } else {
          currentSave = new Saves(rower.getString("name"), rower.getInt("level"), rower.getInt("saveNum"));
          onScreen = false;
          nameScreen.onScreen = true;
        }
      }
      if (save2.isInside()) {
        rower = savesTable.getRow(1);
        if (rower.getInt("new") != 1) {
          currentSave = new Saves(rower.getString("name"), rower.getInt("level"), rower.getInt("saveNum"));
          onScreen = false;
          playing.toggled = true;
          pauseScreen.started = true;
        } else {
          currentSave = new Saves(rower.getString("name"), rower.getInt("level"), rower.getInt("saveNum"));
          onScreen = false;
          nameScreen.onScreen = true;
        }
      }
      if (save3.isInside()) {
        rower = savesTable.getRow(2);
        if (rower.getInt("new") != 1) {
          currentSave = new Saves(rower.getString("name"), rower.getInt("level"), rower.getInt("saveNum"));
          onScreen = false;
          playing.toggled = true;
          pauseScreen.started = true;
        } else {
          currentSave = new Saves(rower.getString("name"), rower.getInt("level"), rower.getInt("saveNum"));
          onScreen = false;
          nameScreen.onScreen = true;
        }
      }
    }
  }
  
  Saves getCurrentSave() {
    return currentSave;
  }
  
  void updateTable() {
    int index = currentSave.saveNumber - 1;
    savesTable.setString(index, 2, currentSave.name);
    savesTable.setInt(index, 1, currentSave.level);
    savesTable.setInt(index, 3, 0);
    saveTable(savesTable, fileName);
    updateButtons();
  }
    
  void display() {
    if (onScreen) {
      textFont(jersey);
      textSize(40);
      textAlign(CENTER);
      fill(255);
      text("SELECT A SAVE:", 250, 100);
      save1.display();
      save2.display();
      save3.display();
      imageMode(CENTER);
      image(logo, width/2, 50);
    }
  }
  
 
}
