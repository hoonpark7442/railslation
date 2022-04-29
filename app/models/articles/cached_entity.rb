module Articles
	CachedEntity = Struct.new(:id, :name, :username) do
		def self.from_object(object)
			new(
				object.id,
				object.name,
				object.username
			)
		end
	end
end