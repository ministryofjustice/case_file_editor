class FileIngester
  def ingest(raw)
    if raw.codepoints.first == 0xFEFF
      raw = raw[1..-1]
    end
    CaseImporter.new(JSON.parse(raw)).import
  end
end
