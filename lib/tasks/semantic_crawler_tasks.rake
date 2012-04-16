require "grit"

desc "Outputs the ChangeLog of the current release (latest release on rubygems.org)"
task :changelog do
    repo = Grit::Repo.new('.')

    currentMerge = repo.log('origin/master', nil, :merges => true)[0].id
    lastMerge = repo.log('origin/master', nil, :merges => true)[1].id
    changes = repo.commits_between(lastMerge, currentMerge)

    tags = repo.tags

    if !changes.nil?
        changes.reverse!

        tags.each do |tag|
            if tag.commit.sha.eql?(changes[0].id)
                puts "=> Current version: \033[0;31m#{tag.name}\033[0m (tagged)"
            end
        end

        changes.each do |commit|
            puts "\033[0;33m#{commit.id[0,7]}\033[0m - #{commit.date} - \033[0;32m#{commit.message}\033[0m"
        end
    end
end
