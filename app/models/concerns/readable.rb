require 'active_support/concern'

module Readable
  extend ActiveSupport::Concern

  included do
    has_one :node, as: :actor, autosave: true
    delegate :read, :unread, :read?, :books, :similar_raters, to: :node

    before_validation :build_node, unless: :persisted?
  end

end