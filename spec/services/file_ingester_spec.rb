RSpec.describe FileIngester do
  describe 'ingest' do
    subject { super().ingest(raw) }

    context 'with a valid JSON file' do
      let(:raw) { '{}' }
      it { is_expected.to be_kind_of(Case) }
    end

    context 'with a valid UTF-8 JSON file with a BOM' do
      let(:raw) { "\xEF\xBB\xBF{}".force_encoding(Encoding::ASCII_8BIT) }
      it { is_expected.to be_kind_of(Case) }
    end

    context 'with an unprocessable input' do
      let(:raw) { '!!#@$@$^' }

      it 'raises an exception' do
        expect { subject }.to raise_exception(StandardError)
      end
    end
  end
end
