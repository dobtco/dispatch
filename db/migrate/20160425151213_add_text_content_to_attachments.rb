class AddTextContentToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :text_content, :text
  end
end
