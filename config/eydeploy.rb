raise 'dont load this'
module EY
  module Serverside
    class DeployBase < Task
      def copy_repository_cache
        raise 'COPYING RELEASE'
        shell.status "Copying to #{paths.active_release}"
        exclusions = Array(config.copy_exclude).map { |e| %|--exclude="#{e}"| }.join(' ')
        run("mkdir -p #{paths.active_release} #{paths.releases_failed} #{paths.shared_config} && rsync -aq #{exclusions} #{paths.repository_cache}/app #{paths.active_release}")

        shell.status "Ensuring proper ownership."
        sudo("chown -R #{config.user}:#{config.group} #{paths.active_release} #{paths.releases_failed}")
      end
    end
  end
end
