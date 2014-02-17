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
    expect_to_have_template(template)
  end

  it 'add template' do
    json = { document_template: { name: 'Test name', type: 'Test type', description: 'Concrete desc', content: { 'key' => 'value' }, is_scan: true } }
    expect { post api_v1_document_templates_path, json }.to change(DocumentTemplate, :count).by(1)

    expect(response).to be_success
    expect_to_have_template(json[:document_template])
  end

  it 'update template' do    
    json = { document_template: { name: 'Test name', type: 'Test type', description: 'Concrete desc', content: { 'key' => 'value' }, is_scan: true } }

    expect { put api_v1_document_template_path(template), json }.to change(DocumentTemplate, :count).by(0)

    expect(response).to be_success

    get api_v1_document_template_path template
    expect(response).to be_success
    expect_to_have_template(json[:document_template])
  end

  it 'delete template' do
    expect { delete api_v1_document_template_path(template) }.to change(DocumentTemplate, :count).by(-1)
  end

  def expect_to_have_template(template)
    expect(json['type']).to eq(template[:type])
    expect(json['name']).to eq(template[:name])
    expect(json['description']).to eq(template[:description])
    expect(json['content']).to eq(template[:content])
    expect(json['is_scan']).to eq(template[:is_scan])
  end
end
