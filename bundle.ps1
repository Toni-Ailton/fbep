$outputFile = "full_project_source.txt"
$files = Get-ChildItem -Recurse -Filter *.lua

# Alte Datei löschen, falls vorhanden
if (Test-Path $outputFile) { Remove-Item $outputFile }

foreach ($file in $files) {
    Add-Content $outputFile "`n--- FILE: $($file.FullName) ---`n"
    Add-Content $outputFile (Get-Content $file.FullName -Raw)
    Add-Content $outputFile "`n--- END OF FILE ---`n"
}

Write-Host "Fertig! Alle Dateien wurden in $outputFile zusammengefasst." -ForegroundColor Green