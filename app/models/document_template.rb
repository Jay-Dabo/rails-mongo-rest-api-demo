class DocumentTemplate
  include Mongoid::Document

  field :type
  field :name
  field :description
  field :content, type: Hash
  field :is_scan, type: Boolean
end
