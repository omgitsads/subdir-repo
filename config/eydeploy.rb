def copy_repository_cache
  shell.status "Copying to #{config.paths.active_release}"
  exclusions = Array(config.copy_exclude).map { |e| %|--exclude="#{e}"| }.join(' ')
  run("mkdir -p #{config.paths.active_release} #{config.paths.releases_failed} #{config.paths.shared_config} && rsync -aq #{exclusions} #{config.paths.repository_cache}/#{config.app}/ #{config.paths.active_release}")

  shell.status "Ensuring proper ownership."
  sudo("chown -R #{config.user}:#{config.group} #{config.paths.active_release} #{config.paths.releases_failed}")
end
