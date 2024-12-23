# gitime-lapse
# (C) TNTSuperMan 2024

$pos = Get-Location
try{
    Write-Host "
@@@@@@@@@@@@@@@@@@@@@@@@
@@    gitime-lapse    @@
@@(C)TNTSuperMan 2024 @@
@@@@@@@@@@@@@@@@@@@@@@@@
"

    $repo = "https://github.com/TNTSuperMan/Rjs"#Read-Host -Prompt "repository url"
    $file = "package.json"#Read-Host -Prompt "file path"
    $maxl = "100"#Read-Host -Prompt "word break size"
    if(Test-Path tmp){
        Remove-Item -Path tmp -Recurse -Force
    }
    mkdir tmp
    Push-Location tmp
    git clone $repo repo

    Push-Location repo

    $list = (git log).split("`n")

    $cid = ""
    $date = ""
    $data = @()
    $isFirst = 1
    for($i = 0;$i -lt $list.Count; $i++){
        if($list[$i] -match "^commit"){
            if($isFirst -eq 1){
                $isFirst = 0
            }else{
                $data = $data + @{cid = $cid; date = $date}
            }
            $cid = $list[$i].Substring(7)
        }
        if($list[$i] -match "^Date:"){
            $date = $list[$i].Substring(5).Trim()
        }
    }
    $data = $data + @{cid = $cid; date = $date}
    [array]::Reverse($data)
    $texts = @()
    $i = 0
    foreach($d in $data){$i++
        git "checkout" $d.cid $file
        if (Test-Path $file) {
            $cnt = [IO.File]::ReadAllText("tmp\repo\"+$file)
            $ltext = "";
            $j = 0;
            for($k = 0;$k -lt $cnt.Length;$k++){
                if(([int]$maxl -lt $j) -or ($cnt.Substring($k,1) -eq "`n")){
                    if([int]$maxl -lt $j){
                        $ltext += "`n"
                    }
                    $j = 0
                }
                $ltext += $cnt.Substring($k, 1)
                $j++;
            }
            $texts += @($d.date + "`n" + $ltext)
        }
        Write-Host "Total commit / ${i}"
    }
    Write-Host "Completed to output code"
}catch{
    Write-Host $_.Exception
}finally{
    Set-Location $pos
}
