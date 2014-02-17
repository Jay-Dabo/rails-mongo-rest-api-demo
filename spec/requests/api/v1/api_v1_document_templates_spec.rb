require 'spec_helper'

describe "Document templates API" do
  let!(:template) { DocumentTemplate.create(name: 'Some template', type: 'Type #1', description: 'Some description', is_scan: false, content: { 'key' => 'value' }) }

  it 'sends a list' do
    get api_v1_document_templates_path
    expect(response).to be_success
  end

  it 'gets a specific template' do
    get api_v1_document_template_path template

    expect(response).to be_success
    expect(json['type']).to eq(template.type)
    expect(json['name']).to eq(template.name)
    expect(json['description']).to eq(template.description)
    expect(json['content']).to eq(template.content)
    expect(json['is_scan']).to eq(template.is_scan)
  end
end
