# frozen_string_literal: true

module ApplicationHelper
  # タイトルを入れるよ
  def full_title(page_title = "")
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      return base_title
    else
      return page_title + " | " + base_title
    end
  end

  def javascript_pack_tag(name)
    javascript_include_tag(manifest["#{name}.js"])
  end

  private

  def manifest
    @manifest ||= load
  end

  def load
    manifest_path = Rails.root.join('public', 'packs', 'parcel-manifest.json')
    if manifest_path.exist?
      JSON.parse manifest_path.read
    else
      {}
    end
  end
end
