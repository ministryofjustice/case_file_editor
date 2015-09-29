class JsonIngester
  def ingest(raw)
    raw.force_encoding Encoding::UTF_8
    if raw.codepoints.first == 0xFEFF
      raw = raw[1..-1]
    end
    JSON.parse(raw)
  end
end
