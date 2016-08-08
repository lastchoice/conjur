Given(/^a resource$/) do
  @current_resource = Resource.create(resource_id: "cucumber:test-resource:#{SecureRandom.uuid}", owner: @current_user || admin_user)
end

Given(/^I set annotation "([^"]*)" to "([^"]*)"$/) do |name, value|
  @current_resource.add_annotation name: name, value: value
end

Given(/^I create (\d+) secret values?$/) do |n|
  n.to_i.times do |i|
    Secret.create resource_id: @current_resource.id, value: i.to_s
  end
end

Given(/^I create a binary secret value?$/) do
  @value = Random.new.bytes(16)
  Secret.create resource_id: @current_resource.id, value: @value
end

Given(/^I permit user "([^"]*)" to "([^"]*)" it$/) do |grantee, privilege|
  grantee = lookup_user(grantee)
  target = @current_resource
  target.permit privilege, grantee
end

Given(/^I grant my role to user "([^"]*)"$/) do |login|
  grantee = lookup_user(login)
  @current_user.grant_to grantee
end

Given(/^I grant user "([^"]*)" to user "([^"]*)"$/) do |grantor, grantee|
  grantor = lookup_user(grantor)
  grantee = lookup_user(grantee)
  grantor.grant_to grantee
end