# TabularEditor-FolderJsonScripts
Scripts for doing useful things to BIM models saved as Tabular Editor Folder style Json

## Scripts
1. presentMeasureDescriptionsAsColumns.ps1
   - Purpose: View your Tabular Editor Model descriptions in Excel.
     - Excel, unlike PowerBI, does not show Tabular Model descriptions as hovertext.
     - With this, you can bring the documentation column into an Excel pivot table to see the Description and Expression attributes of the column without needing to leave Excel.
   - Creates a table in your Tabular Editor model (excluded from source control, for ease of rebuilding and to honor don't-repeat-yourself).
   - Usage: run this after saving changes to your folder-save Tabular Editor Model, but before deploying changes. If you are deploying from the Tabular Editor GUI, close and reopen the project.
   - Invocation:
     ```powershell
     .\presentMeasureDescriptionsAsColumns.ps1 -tabularEditorFolderRoot "$home\source\repos\sample\path" -DocumentationFolderName "NameYourDocumentationTable"
     ```
