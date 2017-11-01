# PySceneDetect

`PySceneDetect` (https://pyscenedetect.readthedocs.io/en/latest/) running on `Ubuntu:16.04` with `Python 2.7.x`.


## Building
```
# docker build https://raw.githubusercontent.com/handflucht/PySceneDetect/master/Dockerfile -t pyscenedetect:latest
```

## Usage
`PySceneDetect` is set as `Entrypoint`:

```
# docker run pyscenedetect
usage: scenedetect [-h] [-v] -i VIDEO_FILE [-o OUTFILE.mkv] [-co OUTPUT.csv]
                   [-t value] [-m num_frames] [-p percent] [-b rows]
                   [-fb percent] [-s STATS_FILE] [-d detection_method] [-l]
                   [-q] [-st time] [-dt time] [-et time] [-df factor]
                   [-fs num_frames] [-si]
scenedetect: error: argument -i/--input is required
```

Analyzing video at `/some/path/video.mp4` and saving each scene to a separate file:

```
# docker run -v /some/path:/video pyscenedetect:latest -i /video/video.mp4 -o /video/video_parts.mp4
[PySceneDetect] Detecting scenes (threshold mode)...
[PySceneDetect] Parsing video video.mp4...
[PySceneDetect] Video Resolution / Framerate: 512 x 288 / 25.000 FPS
Verify that the above parameters are correct (especially framerate, use --force-fps to correct if required).
[PySceneDetect] Processing complete, found 0 scenes in video.
[PySceneDetect] Processed 24563 / 24563 frames read in 39.9 secs (avg 615.7 FPS).
# ls /some/path
video.mp4            video_parts-003.mp4  video_parts-006.mp4
video_parts-001.mp4  video_parts-004.mp4  video_parts-007.mp4
video_parts-002.mp4  video_parts-005.mp4  video_parts-008.mp4
```
