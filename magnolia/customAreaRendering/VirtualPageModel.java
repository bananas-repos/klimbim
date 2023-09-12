package custom.package;

import info.magnolia.context.MgnlContext;
import info.magnolia.jcr.util.ContentMap;
import info.magnolia.jcr.util.NodeTypes;
import info.magnolia.jcr.util.NodeUtil;
import info.magnolia.rendering.engine.AppendableOnlyOutputProvider;
import info.magnolia.rendering.engine.RenderException;
import info.magnolia.rendering.engine.RenderingEngine;
import info.magnolia.rendering.model.RenderingModel;
import info.magnolia.rendering.model.RenderingModelImpl;
import info.magnolia.rendering.template.AreaDefinition;
import info.magnolia.rendering.template.TemplateDefinition;
import info.magnolia.rendering.template.assignment.TemplateDefinitionAssignment;
import info.magnolia.rendering.template.configured.ConfiguredTemplateDefinition;
import info.magnolia.repository.RepositoryConstants;
import lombok.Getter;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.jcr.Node;
import java.io.ByteArrayOutputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * This is an example for a custom model class which loads the main area content
 * from a referenced page. Without any content duplication
 * Use the mainContent to display the result in the FTL
 *
 * It uses all the templates of the components and the main area templates
 * Thus "rendering" the content into a string. The content which would be the answer
 * to a client request
 *
 * Usefull also in custom rest endpoints
 * 
 * Currently only the main area is used. If there are more, it needs some work
 */


public class VirtualPageModel<RD extends ConfiguredTemplateDefinition> extends RenderingModelImpl<ConfiguredTemplateDefinition> {

    private static final Logger log = LoggerFactory.getLogger(VirtualPageModel.class);

    private final TemplateDefinitionAssignment templateAssignment;
    private final RenderingEngine renderingEngine;

    @Getter
    private String mainContent = StringUtils.EMPTY;

    @Inject
    public VirtualPageModel(Node content,
                            ConfiguredTemplateDefinition definition,
                            RenderingModel<?> parent,
                            TemplateDefinitionAssignment templateAssignment,
                            RenderingEngine renderingEngine) {
        super(content, definition, parent);
        this.templateAssignment = templateAssignment;
        this.renderingEngine = renderingEngine;

        getContent(); // init contentMap
        this.contentFromRefPage();
    }

    /**
     * Load the main area nodes from referenced page and build the are as string to use in ftl
     *
     */
    private void contentFromRefPage() {
        if(contentMap.containsKey("propertyWithReferencedUUIDinIt")) {
            String refUUID = contentMap.get("propertyWithReferencedUUIDinIt").toString();
            log.debug("Referenced uuid given {}", refUUID);
            try {
                OutputStream outputStream = new ByteArrayOutputStream();
                OutputStreamWriter writer = new OutputStreamWriter(outputStream);
                AppendableOnlyOutputProvider appendable = new AppendableOnlyOutputProvider(writer);

                Node referencedNode = NodeUtil.getNodeByIdentifier(RepositoryConstants.WEBSITE, refUUID);
                Node referencesMainNode = referencedNode.getNode("main");

                List<Node> listOfComponents = NodeUtil.asList(NodeUtil.getNodes(referencesMainNode, NodeTypes.Component.NAME));
                List<ContentMap> components = new ArrayList<ContentMap>();
                for (Node node : listOfComponents) {
                    components.add(new ContentMap(node));
                }
                Map<String, Object> contextObjects = new HashMap<String, Object>();
                contextObjects.put("components", components);

                TemplateDefinition mainDef = templateAssignment.getAssignedTemplateDefinition(referencedNode);
                Map<String, AreaDefinition> areas = mainDef.getAreas();
                // limitation to only one area right now.
                try {
                    renderingEngine.render(referencesMainNode, areas.get("main"), contextObjects, appendable);
                } catch (RenderException e) {
                    throw new RuntimeException(e);
                }

                ((Writer) appendable.getAppendable()).flush();

                mainContent = outputStream.toString();

            } catch (Exception e) {
                log.warn("Can not resolve given page with uuid {} for virtual page {}", refUUID, contentMap.get("uuid"));
            }
        }
    }
}
