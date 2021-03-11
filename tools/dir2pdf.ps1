[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [System.IO.DirectoryInfo]
    $文件夹 = "/home/x/下载",
    [Parameter()]
    [System.IO.FileInfo]
    $并后文件名 = "/home/x/暂.pdf"
)

<# 思路： 
将文件夹及子文件夹内所有pdf文件合并， 书签以文件夹及文件名组织
递归遍历文件夹及其文件
#>

function 遍历 {
    param (
        [Parameter(Mandatory=$true)]
        [System.IO.DirectoryInfo]
        $文件夹
    )


    # 书签层级
    # 不含顶层文件夹为书签
    #$层级 = $($文件夹.FullName -split '/').Length -1  - $Script:始层级
    # 含顶层文件夹为书签
    $层级 = $($文件夹.FullName -split '/').Length - $Script:始层级
    #Write-Host $层级

    # 制作文件夹的书签
    #$跳格 = "`t"*$层级 + $文件夹.BaseName
    #Out-Host -InputObject $跳格
    #Write-Host $文件夹.BaseName; 
    $本层文件 = $文件夹.GetFiles("*.pdf")

    if (($本层文件.Length -gt 0) -or ($文件夹 -eq $Script:文件夹)) {
        $夹签 = "BookmarkBegin`n" + "BookmarkTitle: " + $文件夹.BaseName + "`n" + "BookmarkLevel: ${层级}`n" + "BookmarkPageNumber: " + $Script:总页数 + "`n";
        $Script:书签 += $夹签        
    }

    # 制作本层文件的书签
    
    #Write-Host $本层文件
    $本层文件 | Sort-Object Name -Descending | ForEach-Object{
        $Script:源文件 += "'"+$_.FullName+"'" + " "
        $文层级 = $层级 + 1
        $文签 = "BookmarkBegin`n" + "BookmarkTitle: " + $_.BaseName + "`n" + "BookmarkLevel: ${文层级}`n" + "BookmarkPageNumber: " + $Script:总页数 + "`n";
        $Script:书签 += $文签
        $页信息 = $(pdftk $_.FullName dump_data_utf8 | grep -i NumberOfPages)
        $页数 =[int]( $($页信息 -split ':')[1])
        $Script:总页数 += $页数
        # Write-Host $_.BaseName; 
    }
    #Write-Host "`n"
    
    $子文件夹集 = $文件夹.GetDirectories()
    if ($子文件夹集.Length -gt 0) {
        foreach ($夹 in $子文件夹集){
            遍历 -文件夹 $夹
        }    
    }
    return
}

$始层级 = $($文件夹.FullName -split '/').Length - 1
[int]$总页数 = 1
$书签 = ""
$源文件 = ""

遍历 -文件夹 $文件夹 

Write-Host $书签

# 制作书签文件
if(Test-Path -Path "./书签.txt"){
    Remove-Item -Path "./书签.txt"
}
New-Item -Path "./书签.txt" -ItemType File
Set-Content -Path "./书签.txt" -Value $书签
$书签内容 = Get-Content -Path "./书签.txt"
Write-Host "书签内容：$书签内容"

# 合并源文件
Write-Host "待合并pdf文件： ${源文件}"


#pdftk $($源文件 -split " " | ForEach-Object { if( $_ -ne ''){ "`'$_`'"}}) cat output 暂.pdf
bash -c "pdftk $源文件 cat output 暂.pdf"
Write-Host "PDF合并结果： $?"

# 更新书签
pdftk 暂.pdf update_info_utf8 书签.txt output $并后文件名
#bash -c "pdftk 暂.pdf update_info_utf8 书签.txt output $并后文件名"
Write-Host "PDF书签更新结果： $?"