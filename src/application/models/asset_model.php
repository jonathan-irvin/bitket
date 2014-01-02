class Asset_model extends CI_Model {

    function __construct()
    {
        parent::__construct();
    }
    
    function addAsset($ticket_id,$type_id)
	{
		$this->db->set('ticket_id', $ticket_id); 
		$this->db->set('type_id', $type_id);
		$this->db->insert('bk_assets'); 
	}
    
    function getAssets($ticket_id)
    {
		$this->db->select('*');
		$this->db->from('bk_assets');
		$this->db->join('name', 'bk_assets.type_id = bk_types.type_id');

		$query = $this->db->get();	
		
		foreach ($query->result() as $row)
		{			
			echo $row->name;			
		}
	}
	
	function updateAssetType($asset_id,$newType)
	{
		$data = array(
		   'asset_id' => $asset_id,
		   'type_id' => $newType
        );

		$this->db->update('bk_assets', $data)->where('asset_id', $asset_id); 
	}	
	
	function deleteAsset($asset_id)
	{
		$this->db->delete('bk_assets', array('asset_id' => $asset_id))
	}
}
