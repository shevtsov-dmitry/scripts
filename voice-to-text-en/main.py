from faster_whisper import WhisperModel, BatchedInferencePipeline

model = WhisperModel("turbo", device="cuda", compute_type="float16")

pipeline = BatchedInferencePipeline(model=model)
segments, info = model.transcribe(
    "/home/shd/tmp/voice.wav",
    language="en",
    # batch_size=16,
    vad_filter=True,
    condition_on_previous_text=False,
)
for segment in segments:
    print("%s" % (segment.text))
