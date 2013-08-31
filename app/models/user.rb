require 'typus/orm/active_record/instance_methods'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :books, dependent: :destroy     
  validates_presence_of :username
  validates_uniqueness_of :username 

  include Typus::Orm::ActiveRecord::InstanceMethods 
  
  # If DeviseUser#locale is not found, we will use the default one.
  def locale
    ::I18n.locale
  end

  # def role
  #   Typus.master_role
  # end
end
