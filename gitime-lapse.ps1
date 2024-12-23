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

    $repo = Read-Host -Prompt "repository url"
    $file = Read-Host -Prompt "file path"
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
    $i = 0;
    foreach($d in $data){
        git checkout $d.cid $file
        if (Test-Path $file) {$i++;
            $iS = $i.toString()
            $content = Get-Content $file
            Set-Content -Path ("../gtl"+ $iS +".txt") -Value $d.date
            Add-Content -Path ("../gtl"+ $iS +".txt") -Value $content
        }
    }
}catch{}finally{
    Set-Location $pos
}

