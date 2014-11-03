package serverplus;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;
import lombok.Getter;
import lombok.Setter;

public class Session {
	@Getter @Setter Integer sessionID = 0;
	@Getter @Setter String name;
	@Getter @Setter String user;

	@Getter @Setter boolean serverOn = true;
	@Getter @Setter boolean experimentRunning = false;
	@Getter @Setter boolean registrationWindowOpen = false;
	@Getter @Setter int currentExperiment = -1;
	@Getter @Setter ConcurrentHashMap<String, DeviceInfo> registeredClients = new ConcurrentHashMap<String, DeviceInfo>();
	@Getter @Setter CopyOnWriteArrayList<DeviceInfo> filteredDevices = new CopyOnWriteArrayList<DeviceInfo>();
	@Getter @Setter CopyOnWriteArrayList<DeviceInfo> actualFilteredDevices = new CopyOnWriteArrayList<DeviceInfo>();


	

	public Session(Integer id, String u){
		sessionID=id;
		user=u;
		name="Default";
	}

	public Session(Integer id, String n, String u){
		sessionID=id;
		user=u;
		name=n;
	}
}