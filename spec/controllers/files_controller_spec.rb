# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FilesController, type: :controller do
  describe '#validate' do
    let(:file) { fixture_file_upload('README.md', 'text/markdown') }
    let(:stored_file) { StoredFile.create_from_upload(file) }

    context 'the file is valid' do
      it 'returns valid' do
        get :validate, params: { id: stored_file.key }
        expect(JSON.parse(response.body)).to eq('status' => 'valid')
      end
    end

    context 'the file is invalid' do
      before do
        File.open(stored_file.path, 'a') { |f| f.puts 'foo' }
      end
      it 'returns valid' do
        get :validate, params: { id: stored_file.key }
        expect(JSON.parse(response.body)).to eq('status' => 'invalid')
      end
    end
  end
end
