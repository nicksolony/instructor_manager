module Slugify
  module InstanceMethods
    def slug
        name.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end
  end
    module  ClassMethods
      def find_by_slug(url)
        find {|object| object.slug == (url)}
      end
    end

end
