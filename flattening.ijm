macro "Flattening Action Tool - C039C007T0a08FT5a08lT8a08aTda08t" {

  InputDir = getDirectory("Select a directory containing your lif files");
  Files = getFileByExt(".tif", InputDir);
  
  print("\\Clear");
  print("Flattening *.tif from: " + InputDir);

  setBatchMode(true);
  
  for (n = 0; n < Files.length; n++) {
    FilePath = InputDir + Files[n];
    open(FilePath);
    run("Z Project...", "projection = [Max Intensity]");
    Length = lengthOf(FilePath);
    save(substring(FilePath, 0, Length-4) + "-flat.tif");
    close();
    close();
  }
  
  setBatchMode("exit and display");
  showStatus("Finished flattening images");
  print("Finished flattening images");
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
