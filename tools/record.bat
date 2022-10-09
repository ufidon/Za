@echo off
REM https://trac.ffmpeg.org/wiki/ChangingFrameRate
REM ffmpeg -i <input> -filter:v fps=30 <output>
REM 远程录屏

ffmpeg  -f dshow -i audio="Remote Audio"  -f gdigrab -framerate 10  -i desktop -c:v h264_nvenc -qp 0  %1 