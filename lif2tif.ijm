macro "Lif2Tif Action Tool - C038C007T0708LT6708iTa708fCf00T0h082C007T6h08TTbh08iTeh08f" {

  InputDir = getDirectory("Select a directory containing your lif files");
  Files = getFileByExt(".lif", InputDir);

  print("\\Clear");
  print("Converting *.lif from: " + InputDir);

  setBatchMode(true);

  for (n = 0; n < Files.length; n++) {
    FilePath = InputDir + Files[n];
    OutputDir = replace(FilePath, ".lif", "_tif/");
    File.makeDirectory(OutputDir);
    
    run("Bio-Formats Macro Extensions");
    Ext.setId(FilePath);
    Ext.getSeriesCount(SeriesCount);
    SeriesNames = newArray(SeriesCount);

    for (i = 0; i < SeriesCount; i++) {
      print("\\Update2:Converting image " + (n+1) + "/" + Files.length + " - series " + (i+1) + "/" + SeriesCount);
      Ext.setSeries(i);
      Ext.getSeriesName(SeriesNames[i]);
      run("Bio-Formats Importer", "open=[" + FilePath + "] " + " color_mode=Default view=Hyperstack" + " stack_order=Default " + "series_" + d2s(i+1,0));
      title = getTitle();
      index = lastIndexOf(title, ".lif - ");
      save(OutputDir + "/" + substring(title, index+7, lengthOf(title)) + ".tif");
      close();	
    }
  }
  
  setBatchMode("exit and display");
  showStatus("Finished converting Lif to Tif");
  print("Finished converting lif to tif");
}

function getFileByExt(ext, dir) {
  AllFiles = getFileList(InputDir);
  
  MatchingFilesCount = 0;
  for (i = AllFiles.length; --i >= 0;) {
    Length = lengthOf(AllFiles[i]);
    if (Length > 4 && ext == substring(AllFiles[i], Length-4, Length))
      MatchingFilesCount++;
  }
  
  Files = newArray(MatchingFilesCount);
  CurrentId = 0;
  for (i = AllFiles.length; --i >= 0;) {
    Length = lengthOf(AllFiles[i]);
    if (Length > 4 && ext == substring(AllFiles[i], Length-4, Length))
      Files[CurrentId++] = AllFiles[i];
  }
  
  return Files;
}
