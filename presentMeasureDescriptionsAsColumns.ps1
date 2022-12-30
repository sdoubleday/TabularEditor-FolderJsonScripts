PARAM(
    [ValidateNotNullorEmpty()][ValidateScript({
                IF (Test-Path -PathType Container -Path $_ ) 
                    {$True}
                ELSE {
                    Throw "$_ is not a Directory."
                } 
            })][String]$tabularEditorFolderRoot
)
BEGIN{

}
PROCESS{
    $listOfTables = Get-ChildItem $tabularEditorFolderRoot\tables;
    $listOfTables | ForEach-Object {
        $thisTablePath = $_;
        Get-ChildItem "$thisTablePath\columns\Description - *" | Remove-Item;
        Get-ChildItem $thisTablePath\measures\ | ForEach-Object {
            $json = Get-Content $_ | ConvertFrom-Json ;
            $template = [PSCustomObject] @{
                type = 'calculated';
                datatype = 'string';
                displayFolder = 'Documentation';
                name = "Description - $($json.name)";
                expression = $($json.name) + " - DESCRIPTION - " + $( $($json.description) -replace '"', '""' ) + " EXPRESSION - " + $( $($json.expression) -replace '"', '""' ) ;
                description = "Autogenerated Documentation Column."
            };
            New-Item -Force -ItemType File $thisTablePath\columns\$($template.name) | Add-Content -Encoding UTF8 -Value $( $template | ConvertTo-Json ) ;
        }
    }
}
END{}