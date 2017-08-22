package com.jpa.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.jpa.entities.UserSiteAccess;

public interface UserSiteAccessRepo extends JpaRepository<UserSiteAccess, Long> {

	@Query("from UserSiteAccess usa where usa.user.userId=:userId")
	public List<UserSiteAccess> findSiteAssignedFor(@Param(value="userId") Long userId);

	@Query("from UserSiteAccess usa where usa.user.userId=:userId and usa.site.siteId=:siteId")
	public UserSiteAccess findAccessDetails(@Param(value="userId") Long userId, @Param(value="siteId") Long siteId);

}
