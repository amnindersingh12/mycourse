class Recipient < ApplicationService
  def initialize(owner)
    @owner = owner
  end

  def call
    @owner.main_courses.includes(:subscribers).map do |x|
      x.subscribers.pluck(:email)
    end.flatten.uniq - [@owner.email]
  end

  def list_of_recipient
    Recipient.call(@owner)
  end
end
