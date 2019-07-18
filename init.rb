Redmine::Plugin.register :redmine_cc_addresses do
  name 'Issue CC addresses'
  author 'Nick Peelman'
  author_url 'http://peelman.us'
  url 'https://github.com/ageis/redmine_cc_addresses'
  description 'Allows CC addresses to be attached to an issue'
  version '0.4.0'

  project_module :cc_addresses do |map|
    map.permission :edit_cc_addresses, { :cc_addresses => [:create, :destroy] }
  end
end

Rails.configuration.to_prepare do
  require_dependency 'cc_addresses_issue_show_hook'
  require_dependency 'issue'
  unless Issue.included_modules.include? IssuePatch
    Issue.send(:include, IssuePatch)
  end
  MailerPatch.apply
end
