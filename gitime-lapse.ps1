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
    $width = "2000"#Read-Host -Prompt "image width"
    $height ="2000"#Read-Host -Prompt "image height"
    if(Test-Path tmp){
        Remove-Item -Path tmp -Recurse -Force
    }
    git clone $repo tmp

    Push-Location tmp

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
            $cnt = [IO.File]::ReadAllText("tmp\"+$file)
            $texts += @($d.date + "`n" + $cnt)
        }
    }
    Add-Type -AssemblyName System.Drawing

    if(Test-Path imgs){
        Remove-Item -Path imgs -Recurse -Force
    }
    mkdir imgs

    function Draw($text, $i){
        $bmp = [System.Drawing.Bitmap]::new([int]$width, [int]$height)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.TextRenderingHint = "AntiAlias"
    
        $font = [System.Drawing.Font]::new("MS Gothic", 12)
        $black = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::Black)
        $white = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    
        $rect = [System.Drawing.RectangleF]::new(0, 0, [int]$width, [int]$height)
    
        $format = [System.Drawing.StringFormat]::new()
    
        $g.FillRectangle($black, 0, 0, [int]$width, [int]$height)
        $g.DrawString($text, $font, $white, $rect, $format)
    
        $g.Dispose()
        $font.Dispose()
        $Out = [System.IO.Path]::GetFullPath("imgs/"+ $i.ToString() +".png")
        $bmp.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
        $bmp.Dispose()
    }
    $i = 0
    foreach($text in $texts){
        Draw $text $i
        $i++
    }
}catch{
    Write-Host $_.Exception
}finally{
    Set-Location $pos
}
